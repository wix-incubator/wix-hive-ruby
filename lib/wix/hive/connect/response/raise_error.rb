require 'faraday'

module Wix
  module Hive
    module Response
      class RaiseError < Faraday::Response::Middleware
        def on_complete(response)
          status_code = response.status.to_i
          klass = Wix::Hive::Response::Error.errors[status_code]
          return unless klass
          error = klass.from_response(response)
          fail(error)
        end
      end
    end
  end
end

Faraday::Response.register_middleware raise_error: Wix::Hive::Response::RaiseError
