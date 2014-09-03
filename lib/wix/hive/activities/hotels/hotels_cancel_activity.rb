# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-03T12:42:13.889Z

require 'hashie'

module Wix
  module Hive
    module Activities
      module Hotels
        class Refund < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :kind, required: true
          property :total, required: true
          property :currency, required: true
          property :notes
          property :destination, required: true
        end

        class CancelActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :refund, Refund
          coerce_key :guests, Guest
          coerce_key :stay, Stay
          coerce_key :rates, Array[Rate]
          coerce_key :invoice, Invoice
          coerce_key :customer, Customer
          coerce_key :rooms, Array[Room]

          property :cancelDate, required: true
          property :refund, required: true
          property :reservationId
          property :guests, required: true
          property :stay, required: true
          property :rates, default: []
          property :invoice, required: true
          property :customer
          property :rooms, default: []
        end
      end
    end
  end
end
