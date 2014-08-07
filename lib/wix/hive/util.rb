require 'wix/hive/connect/wix_client'

module Wix
  module Hive
    module Util
      def perform(request_method, path, params = {}, body = {})
        request = Hive::Request::WixAPIRequest.new(self, request_method, path, params, body)
        request.perform
      end

      def perform_with_object(request_method, path, klass, params = {}, body = {})
        request = Hive::Request::WixAPIRequest.new(self, request_method, path, params, body)
        request.perform_with_object(klass)
      end

      def perform_with_cursor(request_method, path, klass)
        request = Hive::Request::WixAPIRequest.new(self, request_method, path)
        request.perform_with_cursor(klass)
      end
    end
  end
end
