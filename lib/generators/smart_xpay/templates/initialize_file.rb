UplusSmartXpay.configure do |config|
  config.cst_mid = "YOUR_CST_MID"
  config.cst_platform = "test"
  config.server_id = "01"
  config.time_out = "60"
  config.urls = {
    url: "https://xpayclient.lgdacom.net/xpay/Gateway.do",
    test_url: "https://xpayclient.lgdacom.net:7443/xpay/Gateway.do",
    aux_url: "http://xpayclient.lgdacom.net:7080/xpay/Gateway.do",
  }
  config.mertkeys = {
    tmintshop: "YOUR_MERTKEY"
    mintshop: "YOUR_MERTKEY",
  }
end
