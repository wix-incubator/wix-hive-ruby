require 'spec_helper'

describe Wix::Hive::Util do
  let(:request) { instance_double(Wix::Hive::Request::WixAPIRequest) }
  let(:mock_response) { instance_double(Faraday::Response, :body => 'mock') }
  subject(:util) { (Class.new { include Wix::Hive::Util }).new }

  context '.perform' do
    it 'should create and perform a request' do
      expect(Wix::Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path', {}, {}).and_return(request)
      expect(request).to receive(:perform).and_return(mock_response)

      util.perform('get','/path')
    end
  end

  context '.perform_with_object' do
    it 'should create and perform a request on the given class' do
      expect(Wix::Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path', {}, {}).and_return(request)
      expect(request).to receive(:perform_with_object).with(Wix::Hive::Contact).and_return(mock_response)

      util.perform_with_object('get','/path', Wix::Hive::Contact)

    end
  end

  context '.perform_with_cursor' do
    it 'should create and perform a request and return a cursor' do
      expect(Wix::Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path').and_return(request)
      expect(request).to receive(:perform_with_cursor).with(Wix::Hive::Contact).and_return(mock_response)

      util.perform_with_cursor('get','/path', Wix::Hive::Contact)

    end
  end
end