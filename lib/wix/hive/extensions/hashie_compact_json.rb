require 'hashie'

module Hashie
  module Extensions
    module CompactJSON
      def to_json(*args)
        compact(to_hash).to_json(*args)
      end

      def compact(hash)
        hash.each_with_object({}) do |(k, v), new_hash|
          unless v == {}
            new_hash[k] = v.class == ::Hash ? compact(v) : v
          end
          new_hash
        end
      end
    end
  end
end
