# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T09:53:09.192Z

require 'hashie'

module Wix
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

          property :method, required: true
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

          property :conversionType, required: true
          property :metadata, default: []
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
end
