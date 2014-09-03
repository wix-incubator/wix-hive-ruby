# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T09:53:09.206Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Music
        class LyricsActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :album, Album

          property :album
        end
      end
    end
  end
end
