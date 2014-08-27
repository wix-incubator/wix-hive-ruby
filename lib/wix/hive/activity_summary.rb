require 'hashie'

module Wix
  module Hive
    class ActivityTypeSummary < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      property :activityType
      property :total
      property :from
      property :until
    end

    class ActivitySummary < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::Coercion

      coerce_key :activityTypes, Array[ActivityTypeSummary]

      property :activityTypes
      property :total
      property :from
      property :until
    end
  end
end
