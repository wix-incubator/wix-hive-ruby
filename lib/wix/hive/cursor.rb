require 'hashie'
require 'wix/hive/contact'

module Wix
  module Hive
    class Cursor <  Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      def initialize(client, hash, klass)
        @client = client
        super(hash)
        self.results = results.collect { |item| klass.new(item) }
      end

      property :total
      property :pageSize
      property :previousCursor
      property :nextCursor
      property :results, default: []
    end
  end
end
