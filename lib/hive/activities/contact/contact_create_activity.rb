# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-25T10:43:46.571Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module Contact
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

        property :tag, required: true
        property :email, required: true
      end

      class Phone < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag, required: true
        property :phone, required: true
      end

      class Address < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag, required: true
        property :address
        property :city
        property :region
        property :postalCode
        property :country
      end

      class Date < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag, required: true
        property :date, required: true
      end

      class Url < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :tag, required: true
        property :url, required: true
      end

      class CreateActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Coercion

        coerce_key :name, Name
        coerce_key :company, Company
        coerce_key :emails, Array[Email]
        coerce_key :phones, Array[Phone]
        coerce_key :addresses, Array[Address]
        coerce_key :dates, Array[Date]
        coerce_key :urls, Array[Url]

        property :name
        property :picture
        property :company
        property :emails, default: [], required: true
        property :phones, default: [], required: true
        property :addresses, default: [], required: true
        property :dates, default: [], required: true
        property :urls, default: [], required: true

        def add_email(args)
          emails << Email.new(args)
        end

        def add_phone(args)
          phones << Phone.new(args)
        end

        def add_address(args)
          addresses << Address.new(args)
        end

        def add_date(args)
          dates << Date.new(args)
        end

        def add_url(args)
          urls << Url.new(args)
        end
      end
    end
  end
end
