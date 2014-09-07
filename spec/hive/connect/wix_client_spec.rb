require 'spec_helper'

describe Hive::Client do

  let(:secret_key) { '21c9be40-fda0-4f01-8091-3a525db5dcb6' }
  let(:app_id) { '13832826-96d2-70f0-7eb7-8e107a37f1d2' }
  let(:instance_id) { '138328bd-0cde-04e3-d7be-8f5500e362e7' }
  let(:instance) {'Ikf28Yx7zaY_J0jKyHwvumeSzKde0nuOn-N9ZqzXo_k.eyJpbnN0YW5jZUlkIjoiMTM4MzI4YmQtMGNkZS0wNGUzLWQ3YmUtOGY1NTAwZTM2MmU3Iiwic2lnbkRhdGUiOiIyMDE0LTA5LTA3VDA2OjU5OjEwLjk0NC0wNTowMCIsInVpZCI6ImExMWJiMzM0LWZkZDQtNDUxZi05YWU1LTM5M2U2MTJlNzZhYSIsInBlcm1pc3Npb25zIjoiT1dORVIiLCJpcEFuZFBvcnQiOiJudWxsL251bGwiLCJ2ZW5kb3JQcm9kdWN0SWQiOm51bGwsImRlbW9Nb2RlIjpmYWxzZX0'}
  subject(:client) {
    Hive::Client.new do |config|
      config.secret_key = secret_key
      config.app_id = app_id
      config.instance_id = instance_id
    end
  }

  context '.new' do
    it 'when no secret key is provided' do
      expect { Hive::Client.new }.to raise_error Hive::ConfigurationError
    end

    it 'when no app id is provided' do
      expect { Hive::Client.new( secret_key: secret_key) }.to raise_error Hive::ConfigurationError
    end

    it 'when no instance id is provided' do
      expect { Hive::Client.new( secret_key: secret_key, app_id: app_id) }.to raise_error Hive::ConfigurationError
    end
  end

  context '.parse_instance_data' do
    it 'can parse the instance data' do
      wixInstance = Hive::Client.parse_instance_data(instance, secret_key)

      expect(instance_id).to eq wixInstance.instanceId
    end

    it 'throws an error when the signatures dont match' do
      expect { Hive::Client.parse_instance_data(instance, 'invalid') }.to raise_error Hive::SignatureError
    end

    it 'throws an error when the invalid instance data is provided' do
      expect { Hive::Client.parse_instance_data('invalid', secret_key) }.to raise_error Hive::SignatureError
    end
  end

  it '.headers= appends headers to the default ones' do
    expect(client.headers = {custom: 'custom'})
    stub_get('/v1/actions').with { |request| request.headers.key?('Custom') }.to_return(body: '', headers: {content_type: 'application/json; charset=utf-8'})
    client.request('get', '/v1/actions')
    expect(a_get('/v1/actions')).to have_been_made
  end

  context '.wix_request' do
    it 'should perform a request given a wix_request' do
      time_now = Time.now
      allow(Time).to receive(:now) { time_now }

      request = Hive::Request::WixAPIRequest.new(client, 'get', '/path')
      allow(client).to receive(:request).with(request.verb, request.path, request.options).and_return(instance_double(Faraday::Response, body: 'mock'))

      client.wix_request(request)
    end
  end

  context '.request' do
    it 'passes the custom headers to the request' do
      custom_headers = {custom: '1', custom2: '2'}
      stub_get('/v1/actions').with { |request| request.headers.update(custom_headers) }.to_return(body: '', headers: {content_type: 'application/json; charset=utf-8'})
      client.request('get', '/v1/actions', headers: custom_headers)
      expect(a_get('/v1/actions')).to have_been_made
    end
    it 'passes the parameters to the request' do
      params =  {a: 'a', b: 'b'}
      stub_get('/v1/actions').with(query: params).to_return(body: '', headers: {content_type: 'application/json; charset=utf-8'})
      client.request('get', '/v1/actions', params: params)
      expect(a_get('/v1/actions').with(query: params)).to have_been_made
    end
    it 'catches and reraises Faraday timeout errors' do
      allow(client).to receive(:connection).and_raise(Faraday::Error::TimeoutError.new('execution expired'))
      expect { client.send(:request, :get, '/path') }.to raise_error(Hive::Response::Error::RequestTimeout)
    end
    it 'catches and reraises Timeout errors' do
      allow(client).to receive(:connection).and_raise(Timeout::Error.new('execution expired'))
      expect { client.send(:request, :get, '/path') }.to raise_error(Hive::Response::Error::RequestTimeout)
    end
    it 'catches and reraises Faraday client errors' do
      allow(client).to receive(:connection).and_raise(Faraday::Error::ClientError.new('connection failed'))
      expect { client.send(:request, :get, '/path') }.to raise_error(Hive::Response::Error)
    end
    it 'catches and reraises JSON::ParserError errors' do
      allow(client).to receive(:connection).and_raise(JSON::ParserError.new('unexpected token'))
      expect { client.send(:request, :get, '/path') }.to raise_error(Hive::Response::Error)
    end
  end

  context '#connection' do
    it 'looks like Faraday connection' do
      expect(client.send(:connection)).to respond_to(:run_request)
    end
  end

end
