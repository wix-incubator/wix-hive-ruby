module Wix
  module Hive
    module Connect
      require 'base64'

      class BaseRequestObject
        def initialize(verb, path, secret_key)
          @verb = verb
          @secret_key = secret_key
          @path = ''
          @post_data = nil
        end

        def add_post_data(data)
          @post_data = data;
        end

        def sign_data(data)
          hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @secret_key, data)
          Base64.urlsafe_encode64(hmac).gsub('=','')
        end

        private
        def calculate_signature
          param_array = headers.wix.merge(query).sort.values
          out = @verb + '\n'
          + (@path != nil ? @path + '\n' : '')
          + param_array.join('\n')
          + ((@post_data != nil) ? '\n' + @post_data : '')
          sign_data(out)
        end

        def headers
          WixHeaders.new(nil, nil)
        end

        def query
          nil
        end

        attr_accessor :post_data
      end
    end
  end
end