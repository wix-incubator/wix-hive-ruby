require 'spec_helper'

describe Wix::Hive::REST::Activities do

  subject(:activities) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Activities }).new }

  it '.activities' do
    expect(activities).to receive(:perform_with_cursor).with(:get, '/v1/activities', Wix::Hive::Activity, {params: {pageSize: 50}}).and_return(instance_double(Faraday::Response, body: 'mock'))
    activities.activities(pageSize: 50)
  end
end