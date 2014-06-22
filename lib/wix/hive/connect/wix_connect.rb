module Wix
  module Hive
    module Connect
      class WixPaths
        def initialize
          @paths = []
        end

        def <<(path)
          @paths << path
        end

        def has_paths
          @paths.length > 0
        end

        def to_s
          @paths.join('/')
        end
      end

      class WixHeaders
        def initialize(wix, all=nil)
          @wix = wix, @all = all
        end

        attr_reader :wix, :all
      end

      class WixParameters
        def initialize
          @parameters = Hash.new
        end

        def add_parameter(param, value)
          normalized = value;
          if value.is_a? Array then
            normalized = value.join(',')
          elsif value.is_a? String then
            normalized = value.strip
          end
          @parameters[param] = normalized
        end

        def add_parameters(parameters)
          parameters.parameters.each{ |k, v| @parameters[k] = v}
        end

        def to_query
          res = ''
          @parameters.each {|k, v| res + ((res.length > 0 ? '&' : '') + k + '=' + v)}
          res
        end

        def to_s
          to_query
        end

        private
          attr_accessor :parameters
      end
    end
  end
end