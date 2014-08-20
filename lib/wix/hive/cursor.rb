require 'hashie'
require 'wix/hive/contact'

module Wix
  module Hive
    class Cursor <  Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      def initialize(hash, klass, current_request)
        @next_request = current_request.clone
        @klass = klass
        super(hash)
        self.results = results.map { |item| klass.new(item) }
      end

      property :total
      property :pageSize
      property :previousCursor
      property :nextCursor
      property :results, default: []

      def next_page
        @next_request.params.merge!(:cursor => nextCursor)
        @next_request.perform_with_cursor(@klass)
      end
    end
  end
end
