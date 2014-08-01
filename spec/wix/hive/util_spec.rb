require 'spec_helper'

describe Wix::Hive::Util do
  subject(:util) { (Class.new { include Wix::Hive::Util }).new }

  context '.perform_with_object' do
    it 'should create and perform a request on the given class' do
      request = instance_double(Wix::Hive::Request::WixAPIRequest)

      allow(Wix::Hive::Request::WixAPIRequest).to receive(:new).with(util, 'get', '/path').and_return(request)
      allow(request).to receive(:perform_with_object).with(Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))

      util.perform_with_object('get','/path', Wix::Hive::Contact)

    end
  end
end