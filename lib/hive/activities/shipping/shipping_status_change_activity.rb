# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-30T15:13:42.430Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Shipping
      class ShippingEstimate < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :start
        property :end
      end

      class StatusChangeActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        class ShippingDetail < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :shippingEstimate, ShippingEstimate
          coerce_key :deliveryEstimate, DeliveryEstimate

          property :method
          property :tracking
          property :shippingEstimate
          property :deliveryEstimate
        end

        coerce_key :items, Array[Item]
        coerce_key :shippingDetails, ShippingDetail
        coerce_key :shippingAddress, ShippingAddres

        property :orderId, required: true
        property :status, required: true, transform_with: Hashie::Validate.enum(%w(awaiting_shipment awaiting_payment awaiting_fulfillment partially_shipped))
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
