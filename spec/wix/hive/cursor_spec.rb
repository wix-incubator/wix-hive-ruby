require 'spec_helper'

describe Wix::Hive::Cursor do

  let(:client) { double(Wix::Hive::Client) }
  let(:wix_request) { double(Wix::Hive::Request::WixAPIRequest, client: client, verb: 'get', path: '/path') }
  subject(:cursor) {described_class.new( {total: '50', pageSize: '25', nextCursor: '2', previousCursor: '1', results: ['mock']}, String, wix_request)}

  context '.next?' do
    it 'be true when cursor exists' do
      expect(cursor.next?).to be_truthy
    end
    it 'be false when cursor is 0' do
      cursor.nextCursor = '0'
      expect(cursor.next?).to be_falsey
    end

    it 'be false when cursor is nil' do
      cursor.nextCursor = nil
      expect(cursor.next?).to be_falsey
    end
  end

  context '.previous?' do
    it 'be true when cursor exists' do
      expect(cursor.previous?).to be_truthy
    end
    it 'be false when cursor is 0' do
      cursor.previousCursor = '0'
      expect(cursor.previous?).to be_falsey
    end

    it 'be false when cursor is nil' do
      cursor.previousCursor = nil
      expect(cursor.previous?).to be_falsey
    end
  end

  context '.next_page' do
    it 'should add the next cursor to the request params' do
      params = {}
      expect(wix_request).to receive(:params).and_return(params)
      expect(wix_request).to receive(:perform_with_cursor).with(String).and_return(double(described_class))

      cursor.next_page

      expect(params).to include cursor: '2'
    end

    it 'should throw an error when there is no previous cursor' do
      cursor.nextCursor = nil

      expect{ cursor.next_page }.to raise_error Wix::Hive::CursorOperationError
    end
  end


  context '.previous_page' do
    it 'should add the previous cursor to the request params' do
      params = {}
      expect(wix_request).to receive(:params).and_return(params)
      expect(wix_request).to receive(:perform_with_cursor).with(String).and_return(double(described_class))

      cursor.previous_page

      expect(params).to include cursor: '1'
    end

    it 'should throw an error when there is no previous cursor' do
      cursor.previousCursor = nil

      expect{ cursor.previous_page }.to raise_error Wix::Hive::CursorOperationError
    end
  end
end