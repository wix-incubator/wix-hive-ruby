# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-04T06:21:23.146Z

require 'hashie'

module Hive
  module Activities
    module Conversion
      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :property, required: true
        property :value, required: true
      end

      class CompleteActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :metadata, Array[Metadata]

        property :conversionType, required: true
        property :messageId
        property :metadata, default: []
      end
    end
  end
end
