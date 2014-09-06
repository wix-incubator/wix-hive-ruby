# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-04T11:56:21.957Z

require 'hashie'

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
