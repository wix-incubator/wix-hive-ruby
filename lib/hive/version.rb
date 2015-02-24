module Hive
  class Version
    MAJOR = 1
    MINOR = 0
    PATCH = 1

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end
    end
  end
end
