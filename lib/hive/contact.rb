require 'hashie'

module Hive
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
    property :role
    property :name
  end

  class Email < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    property :id
    property :tag
    property :email
    property :contactSubscriptionStatus
    property :siteOwnerSubscriptionStatus
    property :unsubscribeLink
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
    property :date, with: lambda { |v| Time.parse(v) }
  end

  class Note < Hashie::Trash
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
    coerce_key :company, Company
    coerce_key :emails, Array[Email]
    coerce_key :phones, Array[Phone]
    coerce_key :addresses, Array[Address]
    coerce_key :urls, Array[Url]
    coerce_key :dates, Array[Date]
    coerce_key :notes, Array[Note]
    coerce_key :custom, Array[Custom]
    coerce_key :links, Array[Link]
    property :id
    property :name, default: Hive::Name.new
    property :picture
    property :company, default: Hive::Company.new
    property :tags
    property :emails, default: []
    property :phones, default: []
    property :addresses, default: []
    property :urls, default: []
    property :dates, default: []
    property :notes # , default: []
    property :custom # , default: []
    property :createdAt
    property :links
    property :modifiedAt

    remove_method :emails=, :phones=, :addresses=, :urls=, :dates=, :notes=, :custom=, :links=, :tags=

    def add_email(email, tag)
      emails << Email.new(email: email, tag: tag)
    end

    def add_phone(phone, tag)
      phones << Phone.new(phone: phone, tag: tag)
    end

    def add_address(tag, optional_args = {})
      address_hash = { tag: tag }
      address_hash.update(optional_args)

      addresses << Address.new(address_hash)
    end

    def add_url(url, tag)
      urls << Url.new(url: url, tag: tag)
    end

    def add_date(date, tag)
      dates << Date.new(date: date, tag: tag)
    end

    # There is a problem with the API at the moment so we can't post this data to i. CE-2301
    # def add_note(content, modified_at)
    #   notes << Note.new(content: content, modifiedAt: modified_at)
    # end
    #
    # def add_custom(field, value)
    #   custom << Custom.new(field: field, value: value)
    # end
  end

  class ContactSubscriber < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    coerce_key :name, Name
    coerce_key :emails, Array[Email]

    property :id
    property :name, default: Hive::Name.new
    property :emails, default: []
  end
end
