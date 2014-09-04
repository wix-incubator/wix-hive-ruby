require 'spec_helper'

describe Hive::Response::Error do
  body = {message: 'error', errorCode: 403, wixErrorCode: '-20302'}
  let(:response) { double('Response') }
  subject(:error) { described_class.new }

  context '.from_response' do
    it 'should return a empty error when no body is present' do
      expect(response).to receive(:body).and_return(nil)
      described_class.from_response(response)
    end
    it 'should put the body in the exception message unless its a hash' do
      expect(response).to receive(:body).and_return('Error')
      expect(described_class.from_response(response).error_message).to eq 'Error'
    end

    it 'should put the body in the exception message unless its a hash' do
      expect(response).to receive(:body).and_return(body)
      error = described_class.from_response(response)
      expect(error.error_message).to eq 'error'
      expect(error.error_code).to eq 403
      expect(error.wix_error_code).to eq '-20302'
    end
  end

  it '.to_s' do
    expect(response).to receive(:body).and_return(body)
    expect(described_class.from_response(response).to_s).to eq "#{body[:message]}, errorCode: #{body[:errorCode]}, wixErrorCode: #{body[:wixErrorCode]}"
  end
end