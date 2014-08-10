require 'time'
require 'openssl'
require 'base64'
require 'wix/hive/cursor'

module Wix
  module Hive
    module Request
      class CaseSensitiveString < String
        def downcase
          self
        end

        def capitalize
          self
        end
      end

      class WixAPIRequest
        attr_accessor :verb, :path, :options

        def initialize(client, verb, path, options = {})
          @client = client
          @verb = verb
          @path = path
          @options = options
          options[:params] = append_default_params(options.fetch(:params, {}))
          options[:headers] = append_wix_headers(options.fetch(:headers, {}))
        end

        def perform
          @client.wix_request(self).body
        end

        def perform_with_object(klass)
          klass.new(perform)
        end

        def perform_with_cursor(klass)
          Wix::Hive::Cursor.new(@client, perform, klass)
        end

        def body
          @options.fetch(:body, {})
        end

        def body=(body)
          @options[:body] = body
        end

        def params
          @options.fetch(:params, {})
        end

        def params=(params)
          @options[:params] = params
        end

        def headers
          @options.fetch(:headers, {})
        end

        def headers=(headers)
          @options[:headers] = headers
        end

        private

        def append_default_params(params)
          params['version'] ||= @client.api_version
          params
        end

        def append_wix_headers(headers)
          headers.update(wix_headers)
          headers[CaseSensitiveString.new('x-wix-signature')] = calculate_signature
          headers
        end

        def wix_headers
          { CaseSensitiveString.new('x-wix-instance-id') => @client.instance_id,
            CaseSensitiveString.new('x-wix-application-id') => @client.app_id,
            CaseSensitiveString.new('x-wix-timestamp') =>  Time.now.utc.iso8601(3) }
        end

        def calculate_signature
          out = "#{@verb.upcase}\n#{@path}\n
                 #{wix_headers.update(params).values.sort.join("\n")}
                 #{body.empty? ? '' : "\n#{body}"}"
          sign_data(out)
        end

        def sign_data(data)
          hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @client.secret_key, data)
          Base64.urlsafe_encode64(hmac).gsub('=', '')
        end
      end
    end
  end
end
