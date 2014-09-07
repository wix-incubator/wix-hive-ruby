# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-07T15:01:00.750Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module ECommerce
      class Media < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :thumbnail
      end

      class Variant < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :title, required: true
        property :value
      end

      class Item < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :media, Media
        coerce_key :variants, Array[Variant]

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
        property :variants, default: [], required: true

        def add_variant(args)
          variants << Variant.new(args)
        end
      end

      class Coupon < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :total, required: true
        property :formattedTotal
        property :title, required: true
      end

      class Tax < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :total, required: true
        property :formattedTotal
      end

      class Shipping < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :total, required: true
        property :formattedTotal
      end

      class Payment < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :coupon, Coupon
        coerce_key :tax, Tax
        coerce_key :shipping, Shipping

        property :total, required: true
        property :subtotal, required: true
        property :formattedTotal
        property :formattedSubtotal
        property :currency, required: true
        property :coupon
        property :tax
        property :shipping
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

      class BillingAddres < Hashie::Trash
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

      class PurchaseActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :items, Array[Item]
        coerce_key :payment, Payment
        coerce_key :shippingAddress, ShippingAddres
        coerce_key :billingAddress, BillingAddres

        property :cartId, required: true
        property :storeId, required: true
        property :orderId
        property :items, default: [], required: true
        property :payment, required: true
        property :shippingAddress
        property :billingAddress
        property :paymentGateway
        property :note
        property :buyerAcceptsMarketing

        def add_item(args)
          items << Item.new(args)
        end
      end
    end
  end
end
