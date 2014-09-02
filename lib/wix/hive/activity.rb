require 'hashie'
require 'time'
require 'wix/hive/activities/factory'
require 'wix/hive/extensions/hashie_compact_json'

module Wix
  module Hive
    class ActivityResult < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      property :activityId
      property :contactId
    end

    class ActivityDetails < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      property :additionalInfoUrl
      property :summary
    end

    class Activity < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::Coercion
      include Hashie::Extensions::CompactJSON

      coerce_key :activityDetails, ActivityDetails

      property :id
      property :createdAt, default: Time.now.iso8601(3)

      property :activityType, required: true
      alias_method :type=, :activityType=
      alias_method :type, :activityType

      property :activityLocationUrl
      alias_method :locationUrl=, :activityLocationUrl=
      alias_method :locationUrl, :activityLocationUrl

      property :activityDetails, default: ActivityDetails.new
      alias_method :details=, :activityDetails=
      alias_method :details, :activityDetails

      property :activityInfo, required: true
      alias_method :info=, :activityInfo=
      alias_method :info, :activityInfo

      def initialize(hash = {})
        super(hash)
        transform_activity_info unless hash.empty?
      end

      class << self
        def new_activity(activity_type)
          unless Activities::TYPES.find { |e| e == activity_type }
            fail ArgumentError, "Invalid activity type. Valid ones are: #{Activities::TYPES}"
          end

          Wix::Hive::Activity.new(activityType: activity_type.type,
                                  activityInfo: activity_type.klass.new)
        end
      end

      private

      def transform_activity_info
        type = Activities.class_for_type(activityType)

        # rubocop:disable Style/VariableName
        self.activityInfo = type.new(activityInfo) if type
      end
    end
  end
end
