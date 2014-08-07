require 'faraday'

module Wix
  module Hive
    module Response
      class RaiseError < Faraday::Response::Middleware
        def on_complete(_response)
          # TODO
        end
      end
    end
  end
end

Faraday::Response.register_middleware raise_error: Wix::Hive::Response::RaiseError
