# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T12:42:13.839Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Music

        class ShareActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :album, Album

          property :album
          property :sharedTo, required: true

        end

      end
    end
  end
end
