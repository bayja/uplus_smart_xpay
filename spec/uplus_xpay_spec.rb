# encoding: utf-8
require 'spec_helper'

describe UplusXpay do
  before do
    UplusXpay.configure do |config|
      config.cst_mid = "mintshop"
      config.lgd_mertkey = "XXXX00000XXXXX99999"
      config.cst_platform = "test"
    end
  end

  context 'configuration' do
    it 'can config' do
      UplusXpay.cst_mid.should == "mintshop"
      UplusXpay.lgd_mertkey.should == "XXXX00000XXXXX99999"
      UplusXpay.cst_platform.should == "test"
    end

    it 'can find uplus_js_host' do
      UplusXpay::Configuration.cst_platform = 'service'
      UplusXpay.uplus_js_host.should == "http://xpay.uplus.co.kr"

      UplusXpay::Configuration.cst_platform = 'test'
      UplusXpay.uplus_js_host.should == "http://xpay.uplus.co.kr:7080"
    end

    it 'can fetch lgd_mid' do
      UplusXpay.lgd_mid.should == 'tmintshop'

      UplusXpay::Configuration.cst_platform = 'service'
      UplusXpay.lgd_mid.should == 'mintshop'
    end
  end
end