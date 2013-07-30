# encoding: utf-8

module UplusXpay
  class UplusOrder
    attr_reader :config_options

    def initialize(config_options)
      @config_options = config_options
    end

    def lgd_timestamp
      @lgd_timestamp ||= Time.now.strftime('%Y%m%d%H%m%S').to_s
    end

    def lgd_hashdata
      Digest::MD5.hexdigest(UplusXpay.lgd_mid + lgd_oid + lgd_amount + lgd_timestamp + UplusXpay.lgd_mertkey)
    end

    def lgd_buyerip
      buyer_ip
    end

    [:lgd_oid, :lgd_buyer, :lgd_productinfo, :lgd_amount,
     :lgd_buyeremail, :lgd_buyerid, :lgd_buyerip].each do |meth|
      define_method meth do
        config_options[meth]
      end
    end
  end
end
