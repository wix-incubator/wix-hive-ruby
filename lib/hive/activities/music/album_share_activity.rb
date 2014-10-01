# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-01T07:31:22.200Z

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

        property :album, required: true
        property :artist
        property :sharedTo, required: true, transform_with: Hashie::Validate.enum(%w(FACEBOOK GOOGLE_PLUS TWITTER))
      end
    end
  end
end
