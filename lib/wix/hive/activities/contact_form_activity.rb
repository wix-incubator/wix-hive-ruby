# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.496Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities

      class Field < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name
        property :value

      end

      class ContactFormActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :fields, Array[Field]

        property :fields, default: []

      end

    end
  end
end
