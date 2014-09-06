require 'hive/connect/request/wix_api_request'
require 'hive/rest/api'
require 'faraday'
require 'faraday_middleware'
require 'faraday/request/multipart'
require 'json'
require 'timeout'
require 'hive/connect/response/parse_json'
require 'hive/connect/response/raise_error'
require 'hive/connect/response/error'

module Hive
  class Client
    include Hive::REST::API

    attr_accessor :secret_key, :app_id, :instance_id, :api_base, :api_family, :api_version
    API_BASE = 'https://openapi.wix.com'

    def initialize(secret_key, app_id, instance_id)
      @secret_key = secret_key
      @app_id = app_id
      @instance_id = instance_id
      @api_family = 'v1'
      @api_version = '1.0.0'
    end

    def wix_request(request)
      request(request.verb, request.path, request.options)
    end

    def request(method, path, options = {})
      connection.send(method.to_sym) do |request|
        request.url path, options.fetch(:params, {})
        request.headers.update(options.fetch(:headers, {}))
        body = options.fetch(:body, {})
        request.body = body if  body.length > 0
      end
    rescue Faraday::Error::TimeoutError, Timeout::Error => error
      raise(Hive::Response::Error::RequestTimeout, error)
    rescue Faraday::Error::ClientError, JSON::ParserError => error
      raise(Hive::Response::Error, error)
    end

    def middleware
      @middleware ||= Faraday::RackBuilder.new do |faraday|
        # Checks for files in the payload, otherwise leaves everything untouched
        faraday.request :multipart
        # Encodes as "application/json" if not already encoded
        faraday.request :json
        # Encodes as "application/x-www-form-urlencoded" if not already encoded
        faraday.request :url_encoded
        # Handle error responses
        faraday.response :raise_error
        # Parse JSON response bodies
        faraday.response :parse_json
        # Log requests to the STDOUT
        faraday.response :logger
        # Set default HTTP adapter
        faraday.adapter Faraday.default_adapter
      end
    end

    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: {
          accept: 'application/json'
        },
        request: {
          open_timeout: 10,
          timeout: 30
        }
      }
    end

    private

    def connection
      @connection ||= Faraday.new(API_BASE, connection_options)
    end
  end
end