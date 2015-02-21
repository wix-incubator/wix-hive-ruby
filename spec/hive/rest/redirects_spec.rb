require 'spec_helper'

describe Hive::REST::Redirects do

  subject(:redirects) { (Class.new { include Hive::Util; include Hive::REST::Redirects }).new }

  it '.redirects' do
    expect(redirects).to receive(:perform_with_object).with(:get, 'v1/redirects', Hive::Redirects, params: {}).and_return(instance_double(Faraday::Response, body: 'mock'))
    redirects.redirects
  end

end