# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-02T07:46:23.597Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Music
        class TrackShareActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :track, Track
          coerce_key :album, Album

          property :track, default: Track.new
          property :album, default: Album.new
          property :sharedTo
        end
      end
    end
  end
end
