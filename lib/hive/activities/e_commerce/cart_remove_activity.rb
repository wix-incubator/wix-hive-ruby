# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T15:36:12.671Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module ECommerce

      class CartRemoveActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :item, Item

        property :cartId, required: true
        property :storeId
        property :item, required: true


      end

    end
  end
end