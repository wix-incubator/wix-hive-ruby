require 'spec_helper'

describe Wix::Hive::REST::Insights do

  subject(:insights) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Insights }).new }

  it '.activities_summary' do
    expect(insights).to receive(:perform_with_object).with(:get, '/v1/insights/activities/summary', Wix::Hive::ActivitySummary, params: {}).and_return(instance_double(Faraday::Response, body: 'mock'))
    insights.activities_summary
  end

  it '.contact_activities_summary' do
    contact_id = 'id'
    expect(insights).to receive(:perform_with_object).with(:get, "/v1/insights/contacts/#{contact_id}/activities/summary", Wix::Hive::ActivitySummary, params: {}).and_return(instance_double(Faraday::Response, body: 'mock'))
    insights.contact_activities_summary(contact_id)
  end
end