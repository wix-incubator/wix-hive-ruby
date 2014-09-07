# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-07T15:01:00.788Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class TrackPlayedActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        class Track < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :name, required: true
          property :id, required: true
        end

        coerce_key :track, Track
        coerce_key :album, Album

        property :track
        property :album
      end
    end
  end
end
