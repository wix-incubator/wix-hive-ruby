# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-25T10:43:46.580Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

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

        property :conversionType, required: true, transform_with: Hashie::Validate.enum(%w(PAGEVIEW PURCHASE UPGRADE LIKE FAN NONE))
        property :messageId
        property :metadata, default: []

        def add_metadata(args)
          metadata << Metadata.new(args)
        end
      end
    end
  end
end
