# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-30T15:13:42.307Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class FanActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :album, Album
        coerce_key :artist, Artist

        property :album, required: true
        property :artist
      end
    end
  end
end
