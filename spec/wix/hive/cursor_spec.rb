require 'spec_helper'

describe Wix::Hive::Cursor do

  let(:client) { double(Wix::Hive::Client) }
  let(:wix_request) { double(Wix::Hive::Request::WixAPIRequest, client: client, verb: 'get', path: '/path') }
  subject(:cursor) {described_class.new( {total: '50', pageSize: '25', nextCursor: '2', previousCursor: '1', results: ['mock']}, String, wix_request)}

  it '.next_page' do
    params = {}
    expect(wix_request).to receive(:params).and_return(params)
    expect(wix_request).to receive(:perform_with_cursor).with(String).and_return(double(described_class))

    cursor.next_page

    expect(params).to include cursor: '2'
  end
end