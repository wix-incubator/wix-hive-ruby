module Wix
  module Hive
    class BaseAPIObject
      def initialize(secret_key, app_id, instance_id)
        @secret_key = secret_key
        @app_id = app_id
        @instance_id = instance_id
      end

      private
      def create_request(verb, path)
        Wix::Hive::Connect::WixAPIRequest.new(verb, path, @secret_key, @app_id, @instance_id)
      end
    end
  end
end