require 'spec_helper'

describe Wix::Hive::Response::RaiseError do
  let(:response) { double('Response') }
  subject(:error_raiser) { described_class.new } # a better name would be raise_error but that's a namespace conflict.

  context '.on_complete' do
    it 'raises a Forbidden error when the response code is 403' do
      expect(response).to receive(:status).and_return(403)
      expect(response).to receive(:body).and_return({message: 'error', errorCode: 403, wixErrorCode: '-20302'})
      expect{ error_raiser.on_complete(response) }.to raise_error(Wix::Hive::Response::Error::Forbidden)
    end

    it 'returns nil when the response code is 200' do
      expect(response).to receive(:status).and_return(200)
      expect(error_raiser.on_complete(response)).to be_nil
    end
  end
end