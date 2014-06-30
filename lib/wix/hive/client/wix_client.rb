require 'date'

module Wix
  module Hive
    module Client

      class WixPagingData
        def initialize(initial_result, wix_api_callback)
          @current_data = initial_result
          @wix_api_callback = wix_api_callback
        end

        def can_yield_data(data, mode)
          if data != nil
            field = data.next_cursor
            if mode == 'previous'
              field = data.previous_cursor
            end
            return field != nil && field != 0
          end
          false
        end

        # Determines if this cursor can yield additional data
        # @returns {boolean}
        def has_next
          can_yield_data(@current_data, 'next')
        end


        # Determines if this cursor can yield previous data
        # @returns {boolean}
        def has_previous
          can_yield_data(@current_data, 'previous')
        end

        # Returns the next page of data for this paging collection
        # @returns {WixPagingData}
        def next
          @wix_api_callback.call(@current_data.next_cursor)
        end

        # Returns the previous page of data for this paging collection
        # @returns {WixPagingData}
        def previous
          @wix_api_callback.call(@current_data.previous_cursor)
        end

        # Returns an array of items represented in this page of data
        # @returns {array}
        def results
          @current_data.results
        end

      end

      class WixApiCaller

        attr_reader :app_id, :secret_key, :instance_id

        def with_app_id (app_id)
          @app_id = app_id
          self
        end

        def with_secret_key (secret_key)
          @secret_key = secret_key
          self
        end

        def with_instance_id (instance_id)
          @instance_id = instance_id
          self
        end

        def create_request (verb, path)
          wixconnect.new.create_request(verb, path, @secret_key, @app_id, @instance_id);
        end

        def resource_request (request, callback)
          #TODO
        end

        SCOPE = [
            SITE = 'site',
            APP = 'app'
        ]
      end

      class Wix

        attr_accessor :Activities, :Contacts, :Insights

        def initialize(secret_key, app_id, instance_id)
          @Activities = Activities.new.with_secret_key(secret_key).with_app_id(app_id).with_instance_id(instance_id)
          @Contacts = Contacts.new.with_secret_key(secret_key).with_app_id(app_id).with_instance_id(instance_id)
          @Insights = Insights.new.with_secret_key(secret_key).with_app_id(app_id).with_instance_id(instance_id)
        end

      end

      def throw_missing_value(param_name)
        raise WixAPIException, "Missing parameter: " + param_name
      end

      # Returns an interface to the Wix API
      # @param {String} secret_key Your applications Secret Key
      # @param {String} app_id Your applications App Id
      # @param {String} instance_id Your applications instanceid
      # @returns {Wix} Wix API interface object
      def getAPI (secret_key, app_id, instance_id)
         Wix.new(secret_key, app_id, instance_id);
      end

      # Creates a Wix API object with the give credentials.
      # @param {Object} data JSON data containing credentials for the API: 'secretKey', 'appId', 'instance' or 'instanceId'
      # @returns {Wix} a Wix API interface object
      def with_credentials (data)
        if !data.has_own_property('secret_key')
          throw_missing_value('secret_key')
        end
        if !data.has_own_property('app_id')
          throw_missing_value('app_id')
        end
        if !data.has_own_property('instance_id') && !data.has_own_property('instance')
            throw_missing_value('instance_id or instance')
        end

        i = nil
        if data.has_own_property('instance_id')
            i = data.instance_id;
        else
           i = wixconnect.parse_instance(data.instance, data.secret_key).instance_id;
        end
        Wix.new(data.secret_key, data.app_id, i)
      end

      # Returns an interface to a {wix/connect} module
      # @returns {WixConnect}
      def get_connect
        wixconnect
      end

    end
  end
end