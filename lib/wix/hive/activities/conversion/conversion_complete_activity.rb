# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-29T12:10:00.483Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities
      module Conversion

        class Metadata < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :property
          property :value

        end

        class CompleteActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :metadata, Array[Metadata]

          property :conversionType
          property :messageId
          property :metadata, default: []

        end

      end
    end
  end
end
