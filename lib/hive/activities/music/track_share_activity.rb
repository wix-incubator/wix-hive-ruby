# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-10T14:02:21.569Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class TrackShareActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        class Album < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :name
          property :id
        end

        coerce_key :track, Track
        coerce_key :album, Album
        coerce_key :artist, Artist

        property :track
        property :album
        property :artist
        property :sharedTo, required: true, transform_with: Hashie::Validate.enum(%w(FACEBOOK GOOGLE_PLUS TWITTER))
      end
    end
  end
end
