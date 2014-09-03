# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T09:53:09.255Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Hotels
        class Error < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :errorCode
          property :reason
        end

        class PurchaseFailedActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          class Payment < Hashie::Trash
            include Hashie::Extensions::IgnoreUndeclared
            include Hashie::Extensions::Coercion

            coerce_key :error, Error

            property :subtotal, required: true
            property :total, required: true
            property :currency, required: true
            property :source, required: true
            property :error
          end

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
        end
      end
    end
  end
end
