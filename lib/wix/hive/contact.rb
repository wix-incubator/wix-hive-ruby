require 'hashie'

module Wix
  module Hive
    class Name < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :prefix
      property :first
      property :middle
      property :last
      property :suffix
    end
    class Email < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :tag
      property :email
      property :contactSubscriptionStatus
      property :siteOwnerSubscriptionStatus
    end
    class Phone < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :tag
      property :phone
      property :normalizedPhone
    end
    class Address < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :tag
      property :address
      property :neighborhood
      property :city
      property :region
      property :country
      property :postalCode
    end
    class Url < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :tag
      property :url
    end
    class Date < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :tag
      property :date
    end
    class Notes < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :modifiedAt
      property :content
    end
    class Custom < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :id
      property :field
      property :value
    end
    class Link < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      property :href
      property :rel
    end
    class Contact < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::Coercion
      coerce_key :name, Name
      coerce_key :emails, Array[Email]
      coerce_key :phones, Array[Phone]
      coerce_key :addresses, Array[Address]
      coerce_key :urls, Array[Url]
      coerce_key :dates, Array[Date]
      coerce_key :notes, Array[Notes]
      coerce_key :custom, Array[Custom]
      coerce_key :links, Array[Link]
      property :id
      property :name , default: Wix::Hive::Name.new
      property :picture
      property :company
      property :tags
      property :emails, default: [Wix::Hive::Email.new]
      property :phones
      property :addresses
      property :urls
      property :dates
      property :notes
      property :custom
      property :createdAt
      property :links
      property :modifiedAt
    end
  end
end