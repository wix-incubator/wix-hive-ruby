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
require 'hive/version'
require 'logger'

module Hive
  class Client
    include Hive::REST::API

    attr_accessor :secret_key, :app_id, :instance_id, :api_family, :api_version, :logger, :api_base
    attr_writer :user_agent

    def initialize(options = {})
      # Defaults
      @api_family = 'v1'
      @api_version = '1.0.0'
      @api_base = 'https://openapi.wix.com'

      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield(self) if block_given?

      validate_configuration!
    end

    def headers=(options = {})
      connection_options[:headers].merge!(options)
    end

    # :nocov:
    def request_config=(options = {})
      connection_options[:request].merge!(options)
    end
    # :nocov:

    # @return [String]
    def user_agent
      @user_agent ||= "Hive Ruby Gem #{Hive::Version}"
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

    class << self
      def parse_instance_data(signed_instance, app_secret)
        signature, encoded_json = signed_instance.split('.', 2)

        fail Hive::SignatureError, 'invalid signed instance' if signature.nil? || encoded_json.nil?

        encoded_json_hack = encoded_json.length.modulo(4) == 0 ? encoded_json :
            encoded_json + ('=' * (4 - encoded_json.length.modulo(4)))

        json_str = Base64.urlsafe_decode64(encoded_json_hack)

        hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, app_secret, encoded_json)

        my_signature = Base64.urlsafe_encode64(hmac).gsub('=', '')

        fail Hive::SignatureError, 'the signatures do not match' if signature != my_signature

        Hashie::Mash.new(JSON.parse(json_str))
      end
    end

    private

    def validate_configuration!
      if secret_key.nil?
        fail Hive::ConfigurationError, "Invalid secret key: #{secret_key}"
      elsif app_id.nil?
        fail Hive::ConfigurationError, "Invalid app id: #{app_id}"
      elsif instance_id.nil?
        fail Hive::ConfigurationError, "Invalid instance id: #{instance_id}"
      end
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
        add_logger(faraday)
        # Set default HTTP adapter
        faraday.adapter Faraday.default_adapter
      end
    end

    # :nocov:
    def add_logger(faraday)
      case @logger
      when :file
        faraday.use Faraday::Response::Logger, Logger.new('hive.log')
      when :stdout
        faraday.use Faraday::Response::Logger
      end
    end
    # :nocov:

    # rubocop:disable Style/MethodLength:
    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: {
          accept: 'application/json',
          user_agent: user_agent
        },
        request: {
          open_timeout: 10,
          timeout: 30
        }
      }
    end

    def connection
      @connection ||= Faraday.new(@api_base, connection_options)
    end
  end
end
