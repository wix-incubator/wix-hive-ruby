require 'hashie'

module Hive
  class Redirect < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared

    property :id
    property :name
    property :description
    property :target
  end

  class Redirects < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    coerce_key :redirects, Array[Redirect]
  end
end
