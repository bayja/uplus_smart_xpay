# encoding: utf-8
require 'spec_helper'

describe UplusXpay do
  before do
    UplusXpay.configure do |config|
      config.cst_mid = "mintshop"
      config.lgd_mertkey = "XXXX00000XXXXX99999"
      config.cst_platform = "test"
      config.server_id = "01"
      config.time_out = "60"
      config.urls = {
        url: "https://xpayclient.lgdacom.net/xpay/Gateway.do",
        test_url: "https://xpayclient.lgdacom.net:7443/xpay/Gateway.do",
        aux_url: "http://xpayclient.lgdacom.net:7080/xpay/Gateway.do",
      }
      config.mertkeys = {
        tmintshop: "XXXX00000XXXXX99999",
        mintshop: "XXXX00000XXXXX99999",
      }
    end
  end

  context 'configuration' do
    it 'can config' do
      UplusXpay.cst_mid.should == "mintshop"
      UplusXpay.lgd_mertkey.should == "XXXX00000XXXXX99999"
      UplusXpay.cst_platform.should == "test"
      UplusXpay.server_id.should == '01'
      UplusXpay.time_out.should == '60'
      UplusXpay.urls.should == {
        url: "https://xpayclient.lgdacom.net/xpay/Gateway.do",
        test_url: "https://xpayclient.lgdacom.net:7443/xpay/Gateway.do",
        aux_url: "http://xpayclient.lgdacom.net:7080/xpay/Gateway.do",
      }
      UplusXpay.mertkeys == {
        tmintshop: "XXXX00000XXXXX99999",
        mintshop: "XXXX00000XXXXX99999",
      }
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