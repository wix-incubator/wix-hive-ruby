# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-29T12:10:00.556Z

require 'hashie'

# rubocop:disable all
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
