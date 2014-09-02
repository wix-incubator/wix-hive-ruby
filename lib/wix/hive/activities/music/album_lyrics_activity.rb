# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-02T07:46:23.575Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Music
        class LyricsActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :album, Album

          property :album, default: Album.new
        end
      end
    end
  end
end
