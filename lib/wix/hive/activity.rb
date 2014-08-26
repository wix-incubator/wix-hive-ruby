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
    end
  end
end
