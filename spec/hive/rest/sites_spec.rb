require 'spec_helper'

describe Hive::REST::Sites do

  subject(:sites) { (Class.new { include Hive::Util; include Hive::REST::Sites }).new }

  it '.sites_site' do
    expect(sites).to receive(:perform_with_object).with(:get, 'v1/sites/site', Hive::Site, params: {}).and_return(instance_double(Faraday::Response, body: 'mock'))
    sites.sites_site
  end
  
  it '.sites_site_pages' do
    expect(sites).to receive(:perform_with_object).with(:get, 'v1/sites/site/pages', Hive::SitePages, params: {}).and_return(instance_double(Faraday::Response, body: 'mock'))
    sites.sites_site_pages
  end

end