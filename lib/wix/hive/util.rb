require 'wix/hive/connect/wix_client'

module Wix
  module Hive
    module Util
      def perform_with_object(request_method, path, klass)
        request = Hive::Request::WixAPIRequest.new(self, request_method, path)
        request.perform_with_object(klass)
      end
    end
  end
end