# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-04T06:21:23.208Z

require 'hashie'

module Hive
  module Activities
    module Music
      class TrackPlayActivity < Hashie::Trash
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
