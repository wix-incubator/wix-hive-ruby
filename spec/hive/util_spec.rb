require 'spec_helper'

describe Hive::Util do
  let(:request) { instance_double(Hive::Request::WixAPIRequest) }
  let(:mock_response) { instance_double(Faraday::Response, body: 'mock') }
  subject(:util) { (Class.new { include Hive::Util }).new }

  context '.perform' do
    it 'should create and perform a request' do
      expect(Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path', {}).and_return(request)
      expect(request).to receive(:perform).and_return(mock_response)

      util.perform('get', '/path')
    end
  end

  context '.perform_with_object' do
    it 'should create and perform a request on the given class' do
      expect(Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path', {}).and_return(request)
      expect(request).to receive(:perform_with_object).with(Hive::Contact).and_return(mock_response)

      util.perform_with_object('get', '/path', Hive::Contact)

    end
  end

  context '.perform_with_cursor' do
    it 'should create and perform a request and return a cursor' do
      expect(Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path', {}).and_return(request)
      expect(request).to receive(:perform_with_cursor).with(Hive::Contact).and_return(mock_response)

      util.perform_with_cursor('get', '/path', Hive::Contact)

    end
  end
end
