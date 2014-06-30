
module Wix
  module Hive
    module Client


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

      class BaseWixAPIObject

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
      end

      class WixActivityDetails

        attr_accessor :summary, :additional_info_url

        def initialize (summary, additional_info_url)
          @summary, @additional_info_url = summary, additional_info_url
        end

      end

      class WixActivity

        @@prototype = BaseWixAPIObject.new
        attr_accessor :created_at, :contact_update, :activity_details, :activity_info, :activity_location_url, :activity_type, :summary

        def initialize(activity_type)
          @created_at = Date.new
          @contact_update =  nil # wixparser.toObject(this.TYPES.CONTACT_CREATE.schema)
          with_activity_type(activity_type)
          @activity_location_url = nil
          @activity_details = WixActivityDetails.new(nil,nil)
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


      class Activities

        include Wix::APIOperations::Create
        include Wix::APIOperations::Delete
        include Wix::APIOperations::List

        @@prototype = WixAPICaller.new

        # Creates a new WixActivity object for the given ActivityType
        # @method
        # @param type {ActivityType} the type of Activity
        # @returns {WixActivity} returns an empty Wix Activity
        def new_activity (type)
          WixActivity.new(type)
        end

        # TODO: Use Create
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

        # TODO see and copy 'retrieve' function behaviour
        # Returns an Activity by id
        # @param activity_id
        # @returns {promise|Q.promise} A promise for the Activity, or an error
        def get_activity_by_id (activity_id)
          resource_request(create_request('GET', '/v1/activities/').with_path_segment(activity_id), nil)

        end

        # TODO Use List instead
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
          response, api_key = Wix.request(:get, activity_types_url, @api_key, params)
          response #TODO convert to activity type object
        end

        private

        def activity_url
          url + '/activities'
        end

        def activity_types_url
          url + '/activities/types'
        end

        def get_activity (activity_id)
          url + '/activities/' + activity_id
        end

      end
    end
  end
end