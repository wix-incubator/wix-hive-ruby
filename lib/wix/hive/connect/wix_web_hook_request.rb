module Wix
  module Hive
    module Connect
      class WixWebHookRequest < BaseRequestObject
        def initialize(secret_key)
          super('POST', nil, secret_key)
          @headers = WixParameters.new
          @parameters = WixParameters.new
        end

        def add_parameter(name, value)
          @parameters.add_parameter(name, value);
        end

        def add_header(name, value)
          if name.starts_with('x-wix-') then
            if name == 'x-wix-signature' then
              @signature = value;
            elsif
              @headers.add_parameter(name, value)
            end
          end
        end

        def headers
          WixHeaders.new(@headers, nil)
        end

        def query
          @parameters
        end

        def validate
          sig = calculate_signature
          if sig != @signature then
            raise WixAuthError.new('Signatures do not match, WebHook can not be trusted')
          end
          true
        end
      end
    end
  end
end