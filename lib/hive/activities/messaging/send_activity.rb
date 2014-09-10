# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-10T14:02:21.530Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Messaging
      class Name < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :prefix
        property :first
        property :middle
        property :last
        property :suffix
      end

      class Destination < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :name, Name

        property :target, required: true
        property :name
      end

      class Recipient < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :destination, Destination

        property :method, required: true, transform_with: Hashie::Validate.enum(%w(EMAIL SMS PHONE SOCIAL))
        property :destination, required: true
        property :contactId
      end

      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :property, required: true
        property :value, required: true
      end

      class ConversionTarget < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :metadata, Array[Metadata]

        property :conversionType, required: true, transform_with: Hashie::Validate.enum(%w(PAGEVIEW PURCHASE UPGRADE LIKE FAN NONE))
        property :metadata, default: []

        def add_metadata(args)
          metadata << Metadata.new(args)
        end
      end

      class SendActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :recipient, Recipient
        coerce_key :conversionTarget, ConversionTarget

        property :recipient, required: true
        property :messageId
        property :conversionTarget
      end
    end
  end
end
