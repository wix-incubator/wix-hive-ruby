# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T15:36:12.648Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module ECommerce
      class Item < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :media, Media
        coerce_key :variants, Array[Variant]
        coerce_key :categories, Array[String]
        coerce_key :metadata, Array[Metadata]

        property :id, required: true
        property :sku
        property :title, required: true
        property :quantity, required: true
        property :price
        property :formattedPrice
        property :currency, required: true
        property :productLink
        property :weight
        property :formattedWeight
        property :media
        property :variants, default: []
        property :categories, default: []
        property :metadata, default: []

        def add_variant(args)
          variants << Variant.new(args)
        end

        def add_metadata(args)
          metadata << Metadata.new(args)
        end
      end

      class CartAddActivity < Hashie::Trash
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
