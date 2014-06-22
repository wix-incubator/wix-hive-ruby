module Wix
  module Hive
    module Connect
      class WixAPIRequest < BaseRequestObject
        def initialize(verb, path, secret_key, app_id, instance_id)
          super(verb, path, secret_key)
          @app_id = app_id
          @instance_id = instance_id
          @paths = WixPaths.new
          @additional_params = WixParameters.new
          @version_number = '1.0.0'
          @mode = 'header'
          @timestamp = Date.new.iso8601
        end

        attr_writer :version_number

        def add_segment(segment)
          @paths << segment
        end

        def add_parameter(name, value)
          @additional_params.add_parameter(name, value)
        end

        def header_mode
          @mode = 'header'
        end

        def query_mode
          @mode = 'query'
        end

        private
        def headers
          headers =  WixParameters.new
          if @mode == 'headers' then
            headers.add_parameter('x-wix-instance-id', @instance_id)
            headers.add_parameter('x-wix-application-id', @app_id)
            headers.add_parameter('x-wix-timestamp', @timestamp.to_s)
          end
          all = WixParameters.new
          if self.post_data != nil then
            all.add_parameter('Content-Type', 'application/json')
            all.add_parameter('Content-Length', self.post_data.length)
          end

          WixHeaders.new(headers, all)
        end

        def query
          params = WixParameters.new
          params.add_parameter('version', @version_number)
          params.add_parameters(@additional_params)
          if @mode == 'query' then
            params.add_parameter('instance-id', @instance_id)
            params.add_parameter('application-id', @app_id)
            params.add_parameter('timestamp', @timestamp.to_s)
          end
          params
        end
      end
    end
  end
end
