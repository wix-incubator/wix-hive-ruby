require 'spec_helper'

describe Hashie::Hash do

  context '.flexibly_convert_to_hash' do
    it 'does not raise an error when a class with property method is provided' do
      class_with_method = Wix::Hive::Activities::Messaging::Recipient.new(method: 'method', destination: {target: 'localhost'})
      expect { described_class.new.flexibly_convert_to_hash(class_with_method) }.not_to raise_error
    end

    it 'calls the correct to_hash method' do
      class WithCustomToHash < Hashie::Dash
        property :test

        def to_hash
          {passed: true}
        end
      end

      expect(described_class.new.flexibly_convert_to_hash(WithCustomToHash.new(test: 'mock'))).to include passed: true
    end
  end
end