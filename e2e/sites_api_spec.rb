require_relative './e2e_helper'

describe 'Sites API' do
  it '.sites_site' do
    expect(client.sites_site).to be_a Hive::Site
  end
  
  it '.sites_site_pages' do
    expect(client.sites_site_pages).to be_a Hive::SitePages
  end
end