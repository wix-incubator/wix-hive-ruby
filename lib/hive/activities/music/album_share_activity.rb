# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-25T10:43:46.637Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Music
      class ShareActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :album, Album
        coerce_key :artist, Artist

        property :album
        property :artist
        property :sharedTo, required: true, transform_with: Hashie::Validate.enum(%w(FACEBOOK GOOGLE_PLUS TWITTER))
      end
    end
  end
end
