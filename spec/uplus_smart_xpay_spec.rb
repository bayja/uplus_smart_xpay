# encoding: utf-8
require 'spec_helper'

describe UplusSmartXpay do
  before do
    UplusSmartXpay.configure do |config|
      config.cst_mid = "mintshop"
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
      UplusSmartXpay.cst_mid.should == "mintshop"
      UplusSmartXpay.lgd_mertkey.should == "XXXX00000XXXXX99999"
      UplusSmartXpay.cst_platform.should == "test"
      UplusSmartXpay.server_id.should == '01'
      UplusSmartXpay.time_out.should == '60'
      UplusSmartXpay.urls.should == {
        url: "https://xpayclient.lgdacom.net/xpay/Gateway.do",
        test_url: "https://xpayclient.lgdacom.net:7443/xpay/Gateway.do",
        aux_url: "http://xpayclient.lgdacom.net:7080/xpay/Gateway.do",
      }
      UplusSmartXpay.mertkeys == {
        tmintshop: "XXXX00000XXXXX99999",
        mintshop: "XXXX00000XXXXX99999",
      }
    end

    it 'can find uplus_js_host' do
      UplusSmartXpay::Configuration.cst_platform = 'service'
      UplusSmartXpay.uplus_js_host.should == "http://xpay.uplus.co.kr"

      UplusSmartXpay::Configuration.cst_platform = 'test'
      UplusSmartXpay.uplus_js_host.should == "http://xpay.uplus.co.kr:7080"
    end

    it 'can fetch lgd_mid' do
      UplusSmartXpay.lgd_mid.should == 'tmintshop'

      UplusSmartXpay::Configuration.cst_platform = 'service'
      UplusSmartXpay.lgd_mid.should == 'mintshop'
    end
  end
end