require 'spec_helper'

describe Wix::Hive::REST::Activities do

  subject(:activities) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Activities }).new }

  context '.activities' do
    it 'accepts a pageSize param and it passes it to the request' do
      expect(activities).to receive(:perform_with_cursor).with(:get, '/v1/activities', Wix::Hive::Activity, {params: {pageSize: 50}}).and_return(instance_double(Faraday::Response, body: 'mock'))
      activities.activities(pageSize: 50)
    end

    it 'accepts activityTypes parameter and transforms it before passing it to the request' do
      expect(activities).to receive(:perform_with_cursor).with(:get, '/v1/activities', Wix::Hive::Activity, {params: {activityTypes: 'type1,type2'}}).and_return(instance_double(Faraday::Response, body: 'mock'))
      activities.activities(activityTypes: %w(type1 type2))
    end
  end
end