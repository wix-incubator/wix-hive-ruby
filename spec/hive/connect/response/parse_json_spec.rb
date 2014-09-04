require 'spec_helper'

describe Hive::Response::ParseJson do
  let(:response) { double('Response') }
  subject(:parse_json) { described_class.new }

  context '.on_complete' do
    it 'returns a parsed response when response code is 200' do
      expect(response).to receive(:body).and_return('{"mock":1}')
      expect(response).to receive(:status).and_return(200)
      expect(response).to receive(:body=).with(mock: 1)
      parse_json.on_complete(response)
    end

    it 'leaves the body of the response unchanged if the response contains a unparsable response code' do
      expect(response).to receive(:status).and_return(302)
      parse_json.on_complete(response)
    end

    it 'sets the body to nil when its a whitespace' do
      expect(response).to receive(:body).and_return(' ')
      expect(response).to receive(:status).and_return(200)
      expect(response).to receive(:body=).with(nil)
      parse_json.on_complete(response)
    end
  end

end
