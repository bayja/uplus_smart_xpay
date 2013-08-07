# encoding: utf-8
require 'spec_helper'

describe UplusSmartXpay::UplusOrder do
  let(:config_options) do
    {
      lgd_buyer: 'my_name',
      lgd_productinfo: '상품정보',
      lgd_amount: '14000',
      lgd_buyeremail: 'abc@mintshop.com',
      lgd_buyerid: '9999',
      lgd_oid: "oid_9999",
      lgd_buyerip: '2.2.1.1'
    }
  end

  context 'convert application order to uplus order' do
    it 'can convert basic info' do
      uplus_order = UplusSmartXpay::UplusOrder.new(config_options)
      uplus_order.lgd_buyer.should == "my_name"
      uplus_order.lgd_productinfo.should == "상품정보"
      uplus_order.lgd_amount.should == "14000"
      uplus_order.lgd_buyeremail.should == "abc@mintshop.com"
      uplus_order.lgd_buyerid.should == "9999"
      uplus_order.lgd_buyerip.should == "2.2.1.1"
    end
  end
end