# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T18:01:11.316Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Hotels

      class Guest < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :total, required: true
        property :adults, required: true
        property :children, required: true


      end

      class Stay < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :checkin, required: true
        property :checkout, required: true


      end

      class Tax < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name, required: true
        property :total, required: true
        property :currency, required: true


      end

      class Rate < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :taxes, Array[Tax]

        property :date, required: true
        property :subtotal, required: true
        property :taxes, default: []
        property :total, required: true
        property :currency, required: true

        def add_tax(args)
          taxes << Tax.new(args)
        end


      end

      class Invoice < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :subtotal, required: true
        property :total, required: true
        property :currency, required: true


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
        property :name
        property :phone
        property :email


      end

      class Bed < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :kind, required: true
        property :sleeps


      end

      class Room < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :beds, Array[Bed]
        coerce_key :amenities, Array[String]

        property :id
        property :beds, default: []
        property :maxOccupancy, required: true
        property :amenities, default: []

        def add_bed(args)
          beds << Bed.new(args)
        end


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

        property :source, required: true, transform_with: Hashie::Validate.enum(%w(GUEST STAFF))
        property :reservationId
        property :guests, required: true
        property :stay, required: true
        property :rates, default: []
        property :invoice, required: true
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