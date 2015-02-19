# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T16:58:33.714Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Shipping
      class Variant < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :title, required: true
        property :value
      end

      class Metadata < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :value, required: true
      end

      class Item < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

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

      class DeliveryEstimate < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :start
        property :end
      end

      class ShippingDetail < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :deliveryEstimate, DeliveryEstimate

        property :method, required: true
        property :tracking
        property :deliveryEstimate, required: true
      end

      class ShippingAddres < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :firstName
        property :lastName
        property :email
        property :phone
        property :country
        property :countryCode
        property :region
        property :regionCode
        property :city
        property :address1
        property :address2
        property :zip
        property :company
      end

      class ShippedActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :items, Array[Item]
        coerce_key :shippingDetails, ShippingDetail
        coerce_key :shippingAddress, ShippingAddres

        property :orderId, required: true
        property :items, default: [], required: true
        property :shippingDetails
        property :shippingAddress
        property :note

        def add_item(args)
          items << Item.new(args)
        end
      end
    end
  end
end
