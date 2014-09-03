# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T12:42:13.736Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Contact
        class Field < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :name, required: true
          property :value, required: true
        end

        class FormActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :fields, Array[Field]

          property :fields, default: [], required: true
        end
      end
    end
  end
end
