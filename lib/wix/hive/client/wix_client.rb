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

      # Represents a Wix Activity Type, representing both the schema definition and the Wix Activity name
      # @constructor
      # @class
      # @alias ActivityType
      class ActivityType

        # name - name of the Activity Schema
        # schema - The path to the Activity JSON schema
        def initialize(name, schema)
          @name = name
          @schema = schema
        end

      end

      TYPES = [
          CONTACT_FORM = ActivityType.new('contact/contact-form', './schemas/contacts/contactFormSchema.json'),
          CONTACT_CREATE = ActivityType.new('contacts/create', './schemas/contacts/contactUpdateSchema.json'),
          CONVERSION_COMPLETE = ActivityType.new('conversion/complete', './schemas/conversion/completeSchema.json'),
          PURCHASE = ActivityType.new('e_commerce/purchase', './schemas/e_commerce/purchaseSchema.json'),
          SEND_MESSAGE = ActivityType.new('messaging/send', './schemas/messaging/sendSchema.json'),
          ALBUM_FAN = ActivityType.new('music/album-fan', './schemas/music/album-fanSchema.json'),
          ALBUM_SHARE = ActivityType.new('music/album-share', './schemas/music/album-shareSchema.json'),
          TRACK_LYRICS = ActivityType.new('music/track-lyrics', './schemas/music/album-fanSchema.json'),
          TRACK_PLAY = ActivityType.new('music/track-play', './schemas/music/playSchema.json'),
          TRACK_PLAYED = ActivityType.new('music/track-played', './schemas/music/playedSchema.json'),
          TRACK_SHARE = ActivityType.new('music/track-share',  './schemas/music/track-shareSchema.json'),
          TRACK_SKIP = ActivityType.new('music/track-skip', './schemas/music/skippedSchema.json')
      ]

      class WixActivity

        def initialize(activity_type)
          @created_at = Date.new
          @contact_update =  nil # wixparser.toObject(this.TYPES.CONTACT_CREATE.schema)
          with_activity_type(activity_type)
          @activity_location_url = nil
          @activity_details = nil # {summary : nil, additionalInfoUrl : nil}
          @summary = nil
        end

        # Configures this Activity with a given type
        # @param type {ActivityType} the type of the Activity to create
        # @returns {WixActivity}
        def with_activity_type(type)
          @activity_type = type.name
          @activity_info = nil # wixparser.toObject(type.schema)
          self
        end

        # Configures the activityLocationUrl of this Activity
        # @param url {string} The URL of the Activities location
        # @returns {WixActivity}
        def with_location_url (url)
            @activity_location_url = url
            self
        end

        # Configures the details of this Activity
        # @param summary {string} A summary of this Activity
        # @param additional_info_url {string} a link to additional information about this Activity
        # @returns {WixActivity}
        def with_activity_details (summary, additional_info_url)
            if summary != nil
                @activity_details.summary = summary
            end
            if additional_info_url != nil
                @activity_details.additional_info_url = additional_info_url
            end
            self
        end

        def is_valid
          # TODO provide slightly better validation
          @activity_location_url != nil &&
          @activity_type != nil &&
          @activity_details.summary != nil &&
          @created_at != nil &&
          @activity_details.additional_info_url != nil
        end

        # Posts the Activity to Wix
        # @param session_token {string} The current session token for the active Wix site visitor
        # @param wix {Wix} A Wix API object
        # @returns {promise|Q.promise}
        def post (session_token, wix)
          wix.Activities.post_activity(self, session_token)
        end
      end

      # TODO WixActivity.prototype = BaseWixAPIObject.new

      class WixApiCaller

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

      class Activities

        # Creates a new WixActivity for the given ActivityType
        # @method
        # @param type {ActivityType} the type of Activity
        # @returns {WixActivity} returns an empty Wix Activity
        def new_activity (type)
          WixActivity.new(type)
        end

        # Post an Activity to Wix
        # @param activity {WixActivity} the Activity to post to Wix
        # @param user_session_token {string} The current session token for active Wix user
        # @returns {promise|Q.promise} A new id for the Activity, or an error
        def post_activity (activity, user_session_token)
          if !activity.is_a? WixActivity
              raise 'WixActivity must be provided'
          end
          if !activity.is_valid
              raise 'WixActivity is missing required fields'
          end

          #todo
        end

        # Returns an Activity by id
        # @param activity_id
        # @returns {promise|Q.promise} A promise for the Activity, or an error
        def get_activity_by_id (activity_id)
          resource_request(create_request('GET', '/v1/activities/').with_path_segment(activity_id), nil)
        end

        def get_activities (cursor, date_range)
          request = create_request('GET', '/v1/activities')
          if cursor != nil
            request.with_query_param('cursor', cursor);
          end

          if date_range != nil
            if date_range.has_own_property('from') && date_range.from != nil
                request.with_query_param('from', date_range.from)
            end
            if date_range.has_own_property('until') && date_range.until != nil
                request.with_query_param('until', date_range.until)
            end
          end

          wixApi = self
          resource_request(request, lambda do |data|
            WixPagingData.new(data, lambda do |cursor|
              wixApi.get_activities(cursor, nil)
            end )
          end )

        end

        def get_types
          resource_request(create_request('GET', '/v1/activities/types'), nil)
        end

      end

      # TODO Activities.prototype = WixAPICaller.new

      class Contacts

        def get_contact_by_id (contact_id)
          resource_request(create_request('GET', '/v1/contacts/').with_path_segment(contact_id), nil)
        end

        def get_contacts (cursor)
          request = create_request('GET', '/v1/contacts')
          if cursor != nil
              request.with_query_param('cursor', cursor)
          end
          wixApi = self
          resource_request(request, lambda do |data|
            WixPagingData.new(data, lambda do |cursor|
              wixApi.get_contacts(cursor)
            end )
          end )
        end

        # Creates a new Contact and returns back the ID
        # @param contact {object} JSON representing the Contact
        # @returns {promise|Q.promise} A promise for the Contact ID, or an error
        def create (contact)
          request = create_request('POST', '/v1/contacts');
          # TODO
        end

        def new_contact
          # TODO
          # wixparser.toObject(this.TYPES.CONTACT_CREATE.schema);
        end
      end

      # TODO Contacts.prototype = WixAPICaller.new

      class Insights

        def get_activities_summary (scope)
          request = create_request('GET', '/v1/insights/activities/summary')
          if scope != nil && scope == WixApiCaller.SCOPE.APP || scope == WixApiCaller.SCOPE.SITE
              request.with_query_param('scope', scope)
          end
          resource_request(request, nil)
        end

        def get_activity_summary_for_contact (contact_id)
          resource_request(self.parent.
            create_request('GET', '/v1/insights/contacts').
            with_path_segment(contact_id).
            with_path_segment("activities").
            with_path_segment("summary"), nil)
        end

      end

      #TODO Insights.prototype = WixAPICaller.new

      class Wix

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