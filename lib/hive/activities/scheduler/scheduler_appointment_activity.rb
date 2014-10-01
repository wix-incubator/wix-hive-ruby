# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-10-01T07:31:22.293Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Scheduler
      class Location < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :address
        property :city
        property :region
        property :postalCode
        property :country
        property :url
      end

      class Time < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :start, required: true
        property :end, required: true
        property :timezone, required: true
      end

      class Name < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :prefix
        property :first
        property :middle
        property :last
        property :suffix
      end

      class Attendee < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :name, Name

        property :contactId
        property :name
        property :phone
        property :email
        property :notes
        property :self
      end

      class AppointmentActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :location, Location
        coerce_key :time, Time
        coerce_key :attendees, Array[Attendee]

        property :title, required: true
        property :description, required: true
        property :location
        property :time
        property :attendees, default: []

        def add_attendee(args)
          attendees << Attendee.new(args)
        end
      end
    end
  end
end
