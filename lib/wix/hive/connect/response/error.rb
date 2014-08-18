module Wix
  module Hive
    module Response
      class Error < StandardError
        attr_reader :error_message, :error_code, :wix_error_code

        class << self
          def from_response(response)
            message, error_code, wix_error_code = parse_body(response.body)
            new(message, error_code, wix_error_code)
          end

          # rubocop:disable Style/MethodLength
          def errors
            @errors ||= {
              400 => Wix::Hive::Response::Error::BadRequest,
              403 => Wix::Hive::Response::Error::Forbidden,
              404 => Wix::Hive::Response::Error::NotFound,
              408 => Wix::Hive::Response::Error::RequestTimeout,
              429 => Wix::Hive::Response::Error::TooManyRequests,
              500 => Wix::Hive::Response::Error::InternalServerError,
              502 => Wix::Hive::Response::Error::BadGateway,
              503 => Wix::Hive::Response::Error::ServiceUnavailable,
              504 => Wix::Hive::Response::Error::GatewayTimeout
            }
          end

          private

          def parse_body(body)
            if body.nil?
              ['', '', '']
            elsif !body.is_a?(Hash)
              [body, '', '']
            else
              [body[:message].chomp, body[:errorCode], body[:wixErrorCode]]
            end
          end
        end

        def initialize(message = '', error_code = nil, wix_error_code = '')
          super(message)
          @error_message = message
          @error_code = error_code
          @wix_error_code = wix_error_code
        end

        def to_s
          "#{@error_message}, errorCode: #{@error_code}, wixErrorCode: #{@wix_error_code}"
        end

        # Raised when the HIVE returns a 4xx HTTP status code
        ClientError = Class.new(self)

        BadRequest = Class.new(ClientError)

        Unauthorized = Class.new(ClientError)

        Forbidden = Class.new(ClientError)

        AlreadyFavorited = Class.new(Forbidden)

        AlreadyRetweeted = Class.new(Forbidden)

        DuplicateStatus = Class.new(Forbidden)

        NotFound = Class.new(ClientError)

        NotAcceptable = Class.new(ClientError)

        RequestTimeout = Class.new(ClientError)

        UnprocessableEntity = Class.new(ClientError)

        TooManyRequests = Class.new(ClientError)

        # Raised when the HIVE returns a 5xx HTTP status code
        ServerError = Class.new(self)

        InternalServerError = Class.new(ServerError)

        BadGateway = Class.new(ServerError)

        ServiceUnavailable = Class.new(ServerError)

        GatewayTimeout = Class.new(ServerError)
      end
    end
  end
end
