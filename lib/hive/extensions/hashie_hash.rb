module Hashie
  class Hash < ::Hash
    def flexibly_convert_to_hash(object, options = {})
      if object.method(:to_hash).arity == 0
        object.to_hash
      else
        object.to_hash(options)
      end
    rescue ArgumentError
      # HACK: If the provided object overrides the method() definition (see Hive::Activities::Messaging::Recipient)
      # we don't want the whole conversion to fail. So we assume execute the more likely to be present to_hash method.
      # I have opened an issue here: https://github.com/intridea/hashie/issues/222
      object.to_hash
    end
  end
end
