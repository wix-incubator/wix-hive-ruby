require 'time'
require 'openssl'
require 'base64'
require 'hive/cursor'

module Hive
  module Request
    class WixAPIRequest
      attr_accessor :verb, :path, :body, :params, :headers

      def initialize(client, verb, path, options = {})
        @client = client
        @verb = verb.to_sym
        @path = path
        @body = options.fetch(:body, {})
        @params = options.fetch(:params, {})
        @headers = options.fetch(:headers, {})
      end

      def options
        { body: @body.clone, params: @params.clone, headers: @headers.clone }
      end

      def perform
        sign_request
        @client.wix_request(self).body
      end

      def perform_with_object(klass)
        klass.new(perform)
      end

      def perform_with_cursor(klass)
        Hive::Cursor.new(perform, klass, self)
      end

      def initialize_copy(_other)
        @path = @path.dup
        @body = @body.dup
        @params = @params.dup
        @headers = @headers.dup
      end

      private

      def sign_request
        @timestamp = Time.now.utc.iso8601(3)
        append_default_params
        append_wix_headers
        @headers[CaseSensitiveString.new('x-wix-signature')] = calculate_signature
      end

      def append_default_params
        @params['version'] ||= @client.api_version
      end

      def append_wix_headers
        @headers.update(wix_headers)
      end

      def wix_headers
        { CaseSensitiveString.new('x-wix-instance-id') => @client.instance_id,
          CaseSensitiveString.new('x-wix-application-id') => @client.app_id,
          CaseSensitiveString.new('x-wix-timestamp') =>  @timestamp }
      end

      def calculate_signature
        out = "#{@verb.upcase}\n/#{@path}\n#{sorted_parameter_values.join("\n")}#{@body.empty? ? '' : "\n#{@body}"}"
        sign_data(out)
      end

      def sorted_parameter_values
        {}.update(params).update(wix_headers).sort_by { |k, _v| k.to_s }.map { |_k, v| v }
      end

      def sign_data(data)
        hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @client.secret_key, data)
        Base64.urlsafe_encode64(hmac).gsub(/\+/, '-').gsub(/\//, '_').gsub('=', '')
      end
    end

    class CaseSensitiveString < String
      def downcase
        self
      end

      def capitalize
        self
      end
    end
  end
end
