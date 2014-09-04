require 'hashie'
require 'time'
require 'hive/activities/factory'

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
    # include Hashie::Extensions::CompactJSON

    coerce_key :activityDetails, ActivityDetails

    property :id
    property :createdAt, default: Time.now.iso8601(3)

    property :activityType, from: :type, required: true
    alias_method :type=, :activityType=
    alias_method :type, :activityType

    property :activityLocationUrl, from: :locationUrl
    alias_method :locationUrl=, :activityLocationUrl=
    alias_method :locationUrl, :activityLocationUrl

    property :activityDetails, from: :details, default: ActivityDetails.new
    alias_method :details=, :activityDetails=
    alias_method :details, :activityDetails

    property :activityInfo, from: :info, required: true
    alias_method :info=, :activityInfo=
    alias_method :info, :activityInfo

    def initialize(hash = {})
      super(hash)
      transform_activity_info unless hash.empty?
    end

    private

    def transform_activity_info
      type = Activities.class_for_type(activityType)

      # rubocop:disable Style/VariableName
      self.activityInfo = type.new(activityInfo) if type
    end
  end
end
