# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-02T07:46:23.513Z

require 'hashie'

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
