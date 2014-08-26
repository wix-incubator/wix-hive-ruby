# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.558Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities

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

        property :destination
        property :name, default: Name.new

      end

      class Recipient < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :destination, Destination

        property :method
        property :destination, default: Destination.new
        property :contactId

      end

      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :property
        property :value

      end

      class ConversionTarget < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :metadata, Array[Metadata]

        property :conversionType
        property :metadata, default: []

      end

      class SendActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :recipient, Recipient
        coerce_key :conversionTarget, ConversionTarget

        property :recipient, default: Recipient.new
        property :messageId
        property :conversionTarget, default: ConversionTarget.new

      end

    end
  end
end
