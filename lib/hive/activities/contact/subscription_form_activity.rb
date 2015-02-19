# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T16:58:33.313Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Contact
      class Name < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :prefix
        property :first
        property :middle
        property :last
        property :suffix
      end

      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :value, required: true
      end

      class SubscriptionFormActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :name, Name
        coerce_key :metadata, Array[Metadata]

        property :email, required: true
        property :name
        property :phone
        property :metadata, default: []

        def add_metadata(args)
          metadata << Metadata.new(args)
        end
      end
    end
  end
end
