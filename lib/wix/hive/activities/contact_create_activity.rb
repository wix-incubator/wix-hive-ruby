# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.518Z

require 'hashie'

# rubocop:disable all
module Wix
  module Hive
    module Activities

      class Name < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :prefix
        property :first
        property :middle
        property :last
        property :suffix

      end

      class Company < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :name
        property :role

      end

      class Email < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag
        property :email

      end

      class Phone < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag
        property :phone

      end

      class Address < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag
        property :address
        property :neighborhood
        property :city
        property :region
        property :postalCode
        property :country

      end

      class Date < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag
        property :date

      end

      class Url < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag
        property :url

      end

      class ContactCreateActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :name, Name
        coerce_key :company, Company
        coerce_key :emails, Array[Email]
        coerce_key :phones, Array[Phone]
        coerce_key :addresses, Array[Address]
        coerce_key :dates, Array[Date]
        coerce_key :urls, Array[Url]

        property :name, default: Name.new
        property :picture
        property :company, default: Company.new
        property :emails, default: []
        property :phones, default: []
        property :addresses, default: []
        property :dates, default: []
        property :urls, default: []

      end

    end
  end
end
