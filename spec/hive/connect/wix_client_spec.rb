require 'spec_helper'

describe Hive::Client do

  let(:secret_key) { 's3cret' }
  let(:app_id) { '1111111' }
  let(:instance_id) { '11111' }
  subject(:client) { Hive::Client.new(secret_key, app_id, instance_id) }

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

  context '#middleware' do
    subject(:middleware) { client.middleware }

    it 'sets the default faraday adapter' do
      expect(middleware.handlers).to include Faraday::Adapter::NetHttp
    end

    it 'handles multipart requests' do
      expect(middleware.handlers).to include Faraday::Request::Multipart
    end

    it 'encodes request urls' do
      expect(middleware.handlers).to include Faraday::Request::UrlEncoded
    end

    it 'has a custom response error parser' do
      expect(middleware.handlers).to include Hive::Response::RaiseError
    end

    it 'has a custom response json parser' do
      expect(middleware.handlers).to include Hive::Response::ParseJson
    end

    it 'has a custom response logger' do
      expect(middleware.handlers).to include Faraday::Response::Logger
    end
  end

  context '#connection_options' do
    subject(:connection_options) { client.connection_options }
    # We only care if it sets the builders.
    it { is_expected.to have_key(:builder) }
  end

  context '#connection' do
    it 'looks like Faraday connection' do
      expect(client.send(:connection)).to respond_to(:run_request)
    end
  end

end
