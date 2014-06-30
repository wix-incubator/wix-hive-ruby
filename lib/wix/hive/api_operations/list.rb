module Wix
  module APIOperations
    module List
      module ClassMethods
        def all(filters={}, api_key=nil)
          response, api_key = Wix.request(:get, url, api_key, filters)
          Util.convert_to_wix_object(response, api_key)
        end

        # TODO use this above
        class WixPagingData
          def initialize(initial_result, wix_api_callback)
            @current_data = initial_result
            @wix_api_callback = wix_api_callback
          end

          def can_yield_data(data, mode)
            if data != nil
              field = data.next_cursor
              if mode == 'previous'
                field = data.previous_cursor
              end
              return field != nil && field != 0
            end
            false
          end

          # Determines if this cursor can yield additional data
          # @returns {boolean}
          def has_next
            can_yield_data(@current_data, 'next')
          end


          # Determines if this cursor can yield previous data
          # @returns {boolean}
          def has_previous
            can_yield_data(@current_data, 'previous')
          end

          # Returns the next page of data for this paging collection
          # @returns {WixPagingData}
          def next
            @wix_api_callback.call(@current_data.next_cursor)
          end

          # Returns the previous page of data for this paging collection
          # @returns {WixPagingData}
          def previous
            @wix_api_callback.call(@current_data.previous_cursor)
          end

          # Returns an array of items represented in this page of data
          # @returns {array}
          def results
            @current_data.results
          end

        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
