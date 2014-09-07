module Hashie
  module Validate
    module_function
    def enum(enum)
      lambda do |v|
        fail ArgumentError, "Invalid value #{v} ! Valid ones are: #{enum}" unless enum.include?(v)
        v
      end
    end
  end
end
