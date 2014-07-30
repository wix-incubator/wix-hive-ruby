require 'faraday'
require 'faraday/request/multipart'
require 'json'
require 'timeout'
require 'wix/hive/connect/response/parse_json'
require 'wix/hive/connect/response/raise_error'

module Wix
  module Hive
    module HTTPService
      class << self
        # A customized stack of Faraday middleware that will be used to make each request.
        attr_accessor :middleware
        # A default set of HTTP options
        attr_accessor :connection_options
      end

      module_function

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::RackBuilder]
      def middleware
        @middleware ||= Faraday::RackBuilder.new do |faraday|
          # Checks for files in the payload, otherwise leaves everything untouched
          faraday.request :multipart
          # Encodes as "application/x-www-form-urlencoded" if not already encoded
          faraday.request :url_encoded
          #Handle error responses
          faraday.response :raise_error
          # Parse JSON response bodies
          faraday.response :parse_json
          #Log requests to the STDOUT
          faraday.response :logger
          # Set default HTTP adapter
          faraday.adapter Faraday.default_adapter
        end
      end

      # @return [Hash]
      def connection_options
        @connection_options ||= {
            :builder => middleware,
            :headers => {
                :accept => 'application/json',
            },
            :request => {
                :open_timeout => 10,
                :timeout => 30,
            },
        }
      end

      def make_request(method, path, params = {}, headers = {})
        connection.send(method.to_sym, path, params) { |request| request.headers.update(headers) }.env
      rescue Faraday::Error::TimeoutError, Timeout::Error => error
        #TODO @Alex: Custom error handling propagate for now
        raise(error)
      rescue Faraday::Error::ClientError, JSON::ParserError => error
        #TODO @Alex: Custom error handling propagate for now
        raise(error)
      end

      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        @connection ||= Faraday.new(Wix::Hive.api_base, connection_options)
      end
    end
  end
end