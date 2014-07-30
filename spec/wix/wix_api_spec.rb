require 'spec_helper'

describe Wix::Hive do
  subject(:hive) {Wix::Hive}

  it 'has an api_base accessor' do
    expect(hive).to respond_to :api_base, :api_base=
  end

  it 'has an api_family accessor' do
    expect(hive).to respond_to :api_family, :api_family=
  end

  it 'has an api_version accessor' do
    expect(hive).to respond_to :api_version, :api_version=
  end

  it 'has an http_service accessor' do
    expect(hive).to respond_to(:http_service)
    expect(hive).to respond_to(:http_service=)
  end

  context '#request' do
    it 'passes all its arguments to the http_service' do
      method = 'get'
      path = 'foo'
      params = {:a => 2}
      headers = {:c => :d}

      expect(hive.http_service).to receive(:make_request).with(method, path, params, headers)
      hive.request(method, path, params, headers)
    end
  end
end