require 'hashie'

module Hive
  class Site < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    coerce_key :url
    coerce_key :status

    property :url
    property :status
  end

  class Page < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared

    property :path
    property :wixPageId
    property :appPageId
  end

  class SitePages < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    coerce_key :siteUrl, Site
    coerce_key :pages, Array[Page]

    property :siteUrl
    property :pages, default: []
  end
end
