# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.571Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities

      class Album < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name
        property :id

      end

      class AlbumLyricsActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :album, Album

        property :album, default: Album.new

      end

    end
  end
end
