# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T09:53:09.212Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Music
        class TrackPlayedActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :track, Track
          coerce_key :album, Album

          property :track
          property :album
        end
      end
    end
  end
end
