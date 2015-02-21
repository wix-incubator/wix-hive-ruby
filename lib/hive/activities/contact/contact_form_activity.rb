# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T18:01:10.985Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Contact
      class Field < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :value, required: true
      end

      class ContactFormActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :fields, Array[Field]

        property :fields, default: [], required: true

        def add_field(args)
          fields << Field.new(args)
        end
      end
    end
  end
end
