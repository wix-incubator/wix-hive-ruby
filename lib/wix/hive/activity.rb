require 'hashie'
require 'time'
require 'wix/hive/activities/factory'

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

      coerce_key :activityDetails, ActivityDetails

      property :id
      property :createdAt, default: Time.now.iso8601(3)
      property :activityType
      property :activityLocationUrl
      property :activityDetails, default: ActivityDetails.new
      property :activityInfo

      def initialize(hash = {})
        super(hash)

        transform_activity_info unless hash.empty?
      end

      class << self
        def new_activity(activity_type)
          unless Activities::TYPES.find { |e| e == activity_type }
            fail ArgumentError, "Invalid activity type. Valid ones are: #{Activities::TYPES}"
          end

          activity = Wix::Hive::Activity.new
          activity.activityType = activity_type.type
          activity.activityInfo = activity_type.klass.new

          activity
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
