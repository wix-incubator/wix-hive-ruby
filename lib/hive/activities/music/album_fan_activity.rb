# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-07T15:01:00.773Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class Album < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :id, required: true
      end

      class FanActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :album, Album

        property :album
      end
    end
  end
end
