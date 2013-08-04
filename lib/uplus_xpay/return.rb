# encoding: utf-8

module UplusXpay
  class Return
    attr_reader :lgd_mid, :parsed_resp, :lgd_respcode, :lgd_respmsg, :lgd_response

    def initialize(lgd_mid, parsed_resp)
      @lgd_mid = lgd_mid
      @parsed_resp = parsed_resp
      @lgd_respcode = parsed_resp["LGD_RESPCODE"]
      @lgd_respmsg = parsed_resp["LGD_RESPMSG"]
      @lgd_response = parsed_resp["LGD_RESPONSE"]
    end

    def success?
      lgd_respcode == "0000"
    end
    alias :succeed? :success?

    def valid?
      hash_data = Digest::MD5.hexdigest("#{parsed_resp['LGD_MID']}#{parsed_resp['LGD_OID']}#{parsed_resp["LGD_AMOUNT"]}#{parsed_resp['LGD_RESPCODE']}#{parsed_resp['LGD_TIMESTAMP']}#{config.mertkey(lgd_mid)}")
      hash_data == parsed_resp["LGD_HASHDATA"]
    rescue
      false
    end

    def config
      Configuration
    end
  end
end