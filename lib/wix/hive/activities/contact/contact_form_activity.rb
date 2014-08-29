# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-29T12:10:00.455Z

require 'hashie'

# rubocop:disable all
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
