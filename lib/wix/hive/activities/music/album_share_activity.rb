# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-29T12:10:00.534Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities
      module Music

        class ShareActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :album, Album

          property :album, default: Album.new
          property :sharedTo

        end

      end
    end
  end
end
