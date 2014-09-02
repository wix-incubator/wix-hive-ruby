# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-02T07:46:23.632Z

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

            property :subtotal
            property :total
            property :currency
            property :source
            property :error, default: Error.new
          end

          coerce_key :guests, Guest
          coerce_key :stay, Stay
          coerce_key :rates, Array[Rate]
          coerce_key :payment, Payment
          coerce_key :customer, Customer
          coerce_key :rooms, Array[Room]

          property :reservationId
          property :guests, default: Guest.new
          property :stay, default: Stay.new
          property :rates, default: []
          property :payment, default: Payment.new
          property :customer, default: Customer.new
          property :rooms, default: []
        end
      end
    end
  end
end
