require_relative './e2e_helper'

describe 'Activities API' do

  context '.activities' do
    it 'should return a cursor with activity results' do
      cursored_result = client.activities
      expect(cursored_result).to be_a Wix::Hive::Cursor
      expect(cursored_result.results.first).to be_a Wix::Hive::Activity
    end
  end
end