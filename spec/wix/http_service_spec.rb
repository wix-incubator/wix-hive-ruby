require 'spec_helper'

describe Wix::Hive::HTTPService do
  subject(:http_service){Wix::Hive::HTTPService}

  it 'has a faraday_middleware accessor' do
    expect(http_service).to respond_to :middleware, :middleware=
  end

  it 'has a connection_options accessor' do
    expect(http_service).to respond_to :connection_options, :connection_options=
  end

  context '#middleware' do
    subject(:middleware){http_service.middleware}

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
      expect(middleware.handlers).to include Wix::Hive::Response::RaiseError
    end

    it 'has a custom response json parser' do
      expect(middleware.handlers).to include Wix::Hive::Response::ParseJson
    end

    it 'has a custom response logger' do
      expect(middleware.handlers).to include Faraday::Response::Logger
    end
  end

  context '#connection_options' do
    subject(:connection_options){http_service.connection_options}
    #We only care if it sets the builders.
    it{ is_expected.to have_key(:builder)}
  end

  context '#connection' do
    it 'looks like Faraday connection' do
      expect(http_service.send(:connection)).to respond_to(:run_request)
    end
    it 'memoizes the connection' do
      c1, c2 = http_service.send(:connection), http_service.send(:connection)
      expect(c1.object_id).to eq(c2.object_id)
    end
  end

  context '#make_request' do
    it 'passes the custom headers to the request' do
      custom_headers = {custom: '1', custom2: '2'}
      stub_get('/v1/actions').with{|request| request.headers.update(custom_headers)}.to_return(:body => '', :headers => {:content_type => 'application/json; charset=utf-8'})
      http_service.make_request('get','/v1/actions',{}, custom_headers)
      expect(a_get('/v1/actions')).to have_been_made
    end
    it 'passes the parameters to the request' do
      params =  {a: 'a', b: 'b'}
      stub_get('/v1/actions').with(:query => params).to_return(:body => '', :headers => {:content_type => 'application/json; charset=utf-8'})
      http_service.make_request('get','/v1/actions', params, {})
      expect(a_get('/v1/actions').with(:query => params)).to have_been_made
    end
    it 'catches and reraises Faraday timeout errors' do
      allow(http_service).to receive(:connection).and_raise(Faraday::Error::TimeoutError.new('execution expired'))
      expect { http_service.send(:make_request, :get, '/path') }.to raise_error(Faraday::Error::TimeoutError)
    end
    it 'catches and reraises Timeout errors' do
      allow(http_service).to receive(:connection).and_raise(Timeout::Error.new('execution expired'))
      expect { http_service.send(:make_request, :get, '/path') }.to raise_error(Timeout::Error)
    end
    it 'catches and reraises Faraday client errors' do
      allow(http_service).to receive(:connection).and_raise(Faraday::Error::ClientError.new('connection failed'))
      expect { http_service.send(:make_request, :get, '/path') }.to raise_error(Faraday::Error::ClientError)
    end
    it 'catches and reraises JSON::ParserError errors' do
      allow(http_service).to receive(:connection).and_raise(JSON::ParserError.new('unexpected token'))
      expect { http_service.send(:make_request, :get, '/path') }.to raise_error(JSON::ParserError)
    end
  end
end