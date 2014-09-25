# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-25T10:43:46.633Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class Album < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :id
      end

      class Artist < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :id
      end

      class FanActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :album, Album
        coerce_key :artist, Artist

        property :album
        property :artist
      end
    end
  end
end
