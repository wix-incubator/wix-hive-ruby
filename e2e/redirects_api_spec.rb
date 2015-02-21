require_relative './e2e_helper'

describe 'Redirects API' do
  it '.redirects' do
    expect(client.redirects).to be_a Hive::Redirects
  end
end