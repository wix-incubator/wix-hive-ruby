require 'spec_helper'

describe Wix::Hive do
  context '#api_base' do
    subject(:api_base) {Wix::Hive.api_base}

    it{is_expected.to eq 'https://openapi.wix.com'}

    it 'have a working setter' do
      api_base = 'example.com'
      expect(api_base).to eq 'example.com'
    end
  end

  context '#api_family' do
    subject(:api_family) {Wix::Hive.api_family}

    it{is_expected.to eq 'v1'}

    it 'have a working setter' do
      api_family = 'v2'
      expect(api_family).to eq 'v2'
    end
  end

  context '#api_version' do
    subject(:api_version) {Wix::Hive.api_version}

    it{is_expected.to eq '1.0.0'}

    it 'have a working setter' do
      api_version = '1.0.1'
      expect(api_version).to eq '1.0.1'
    end
  end

  context '#api_url' do
    subject(:hive) {Wix::Hive}
    let (:api_base_url) {"#{hive.api_base}/#{hive.api_family}"}

    it 'should equal the default base url' do
      expect(hive.api_url).to eq api_base_url
    end

    it 'append the correct url at the end of the base' do
      expect(hive.api_url('/test')).to eq "#{api_base_url}/test"
    end
  end

  context '#request' do
    subject(:hive) {Wix::Hive}

    it 'should perform a request' do
      pending('to be implemented')
      expect(hive.request).to
    end
  end
end