# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T12:42:13.778Z

require 'hashie'

module Wix
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
end
