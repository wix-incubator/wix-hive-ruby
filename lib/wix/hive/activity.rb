require 'hashie'

module Wix
  module Hive
    class ActivityDetails < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :additionalInfoUrl
      property :summary
    end

    class Activity < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :createdAt
      property :activityType
      property :activityLocationUrl
      property :activityDetails
      property :activityInfo
    end
  end
end