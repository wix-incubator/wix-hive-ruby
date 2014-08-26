# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.520Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities

      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :property
        property :value

      end

      class ConversionCompleteActivity < Hashie::Trash
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
