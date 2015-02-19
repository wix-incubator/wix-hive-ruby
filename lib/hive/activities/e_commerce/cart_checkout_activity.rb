# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T15:36:12.681Z

require 'hashie'
require 'hive/extensions/hashie_validate_enum'

module Hive
  module Activities
    module ECommerce

      class CartCheckoutActivity < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared

        property :cartId, required: true
        property :storeId


      end

    end
  end
end