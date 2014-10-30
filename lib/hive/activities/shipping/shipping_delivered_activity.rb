# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-30T15:13:42.414Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Shipping
      class Item < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :id, required: true
        property :sku
        property :title, required: true
        property :quantity, required: true
        property :price
        property :formattedPrice
        property :currency, required: true
        property :productLink
      end

      class ShippingDetail < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tracking
      end

      class DeliveredActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :items, Array[Item]
        coerce_key :shippingDetails, ShippingDetail

        property :orderId, required: true
        property :items, default: [], required: true
        property :shippingDetails
        property :note

        def add_item(args)
          items << Item.new(args)
        end
      end
    end
  end
end
