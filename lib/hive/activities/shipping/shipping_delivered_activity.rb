# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T16:58:33.728Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Shipping
      class DeliveredActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        class ShippingDetail < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :tracking
        end

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
