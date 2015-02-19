# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T16:58:33.642Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Hotels
      class Payment < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :subtotal, required: true
        property :total, required: true
        property :currency, required: true
        property :source, required: true
      end

      class PurchaseActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :guests, Guest
        coerce_key :stay, Stay
        coerce_key :rates, Array[Rate]
        coerce_key :payment, Payment
        coerce_key :customer, Customer
        coerce_key :rooms, Array[Room]

        property :reservationId
        property :guests, required: true
        property :stay, required: true
        property :rates, default: []
        property :payment, required: true
        property :customer
        property :rooms, default: []

        def add_rate(args)
          rates << Rate.new(args)
        end

        def add_room(args)
          rooms << Room.new(args)
        end
      end
    end
  end
end
