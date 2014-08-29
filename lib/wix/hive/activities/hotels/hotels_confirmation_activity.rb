# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-29T12:10:00.565Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities
      module Hotels

        class Guest < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :total
          property :adults
          property :children

        end

        class Stay < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :checkin
          property :checkout

        end

        class Taxe < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :name
          property :total
          property :currency

        end

        class Rate < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :taxes, Array[Taxe]

          property :date
          property :subtotal
          property :taxes, default: []
          property :total
          property :currency

        end

        class Invoice < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :subtotal
          property :total
          property :currency

        end

        class Name < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :prefix
          property :first
          property :middle
          property :last
          property :suffix

        end

        class Customer < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :name, Name

          property :contactId
          property :isGuest
          property :name, default: Name.new
          property :phone
          property :email

        end

        class Bed < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared

          property :kind
          property :sleeps

        end

        class Room < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :beds, Array[Bed]

          property :id
          property :beds, default: []
          property :maxOccupancy

        end

        class ConfirmationActivity < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Coercion

          coerce_key :guests, Guest
          coerce_key :stay, Stay
          coerce_key :rates, Array[Rate]
          coerce_key :invoice, Invoice
          coerce_key :customer, Customer
          coerce_key :rooms, Array[Room]

          property :source
          property :reservationId
          property :guests, default: Guest.new
          property :stay, default: Stay.new
          property :rates, default: []
          property :invoice, default: Invoice.new
          property :customer, default: Customer.new
          property :rooms, default: []

        end

      end
    end
  end
end
