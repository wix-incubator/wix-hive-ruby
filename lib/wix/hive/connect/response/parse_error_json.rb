require 'wix/hive/connect/response/parse_json'

module Wix
  module Hive
    module Response
      class ParseErrorJson < Wix::Hive::Response::ParseJson
        def unparsable_status_codes
          super + [200]
        end
      end
    end
  end
end
