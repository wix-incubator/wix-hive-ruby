require 'hashie'
require 'hive/contact'
require 'hive/activity'
require 'hive/errors'

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

    def next?
      !nextCursor.nil? && nextCursor != '0'
    end

    def previous?
      !previousCursor.nil? && previousCursor != '0'
    end

    def next_page
      fail Hive::CursorOperationError, 'Next page not available!' if nextCursor.nil?
      cursored_request(nextCursor)
    end

    def previous_page
      fail Hive::CursorOperationError, 'Previous page not available!' if previousCursor.nil?
      cursored_request(previousCursor)
    end

    private

    def cursored_request(cursor)
      @next_request.params.merge!(cursor: cursor)
      @next_request.perform_with_cursor(@klass)
    end
  end
end
