require 'spec_helper'

describe Wix::Hive::Request::WixAPIRequest do

  let(:client) { instance_double(Wix::Hive::Client, api_version: '1.0.0', secret_key: 's3cret', app_id: '1111111', instance_id: '11111') }
  subject(:wix_request) { Wix::Hive::Request::WixAPIRequest.new(client, 'get', '/path') }

  context '.perform' do
    it 'calls the client wix_request method' do
      allow(client).to receive(:wix_request).with(wix_request).and_return(instance_double(Faraday::Response, body: 'mock'))
      wix_request.perform
    end

    it 'appends the signature just before the request is performed' do
      expect(wix_request.headers).not_to include 'x-wix-signature'
      allow(client).to receive(:wix_request).with(wix_request).and_return(instance_double(Faraday::Response, body: 'mock'))
      wix_request.perform
      expect(wix_request.headers).to include 'x-wix-signature'
    end
  end

  it '.perform_with_object' do
    contact = double('Contact')
    allow(client).to receive(:wix_request).with(wix_request).and_return(instance_double(Faraday::Response, body: 'mock'))
    allow(contact).to receive(:new).with('mock')
    wix_request.perform_with_object(contact)
  end

  it '.perform_with_cursor' do
    contact = double('Contact')
    allow(client).to receive(:wix_request).with(wix_request).and_return(instance_double(Faraday::Response, body: {results: [{mock: 'mock'}]}))
    allow(contact).to receive(:new).with(mock: 'mock')
    wix_request.perform_with_cursor(contact).is_a? Wix::Hive::Cursor
  end

  it '.options' do
    local = wix_request.options
    local[:params].merge!({another: 'param'})

    expect(wix_request.options).not_to eq local
  end

  context 'CaseSensitiveString' do
    subject(:header) { Wix::Hive::Request::CaseSensitiveString.new('test') }

    it 'returns the original string when you call downcase' do
      header == header.downcase
    end

    it 'returns the original string when you call capitalize' do
      header == header.capitalize
    end
  end
end
