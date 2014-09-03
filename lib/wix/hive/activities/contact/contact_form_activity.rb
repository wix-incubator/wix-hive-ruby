# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T09:53:09.104Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Contact
        class Field < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :name
          property :value
        end

        class FormActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :fields, Array[Field]

          property :fields, default: []
        end
      end
    end
  end
end
