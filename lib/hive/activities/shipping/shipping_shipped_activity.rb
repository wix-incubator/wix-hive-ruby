# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-30T15:13:42.423Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Shipping
      class DeliveryEstimate < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :start
        property :end
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

        class ShippingDetail < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :deliveryEstimate, DeliveryEstimate

          property :method, required: true
          property :tracking
          property :deliveryEstimate, required: true
        end

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
