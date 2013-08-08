# encoding: utf-8
require 'httparty'

module UplusSmartXpay
  class Client
    attr_reader :cst_platform, :cst_mid, :lgd_paykey

    def self.call(options)
      new(options).transact
    end

    def initialize(options)
      normalize_options!(options)
      @cst_platform = options.fetch(:cst_platform) { "service" }
      @cst_mid = options.fetch(:cst_mid)
      @lgd_paykey = options.fetch(:lgd_paykey)
    end

    def transact
      post_body = {
        "LGD_TXID" => tx_id,
        "LGD_AUTHCODE" => auth_code,
        "LGD_MID" => lgd_mid,
        "LGD_TXNAME" => txname,
        "LGD_PAYKEY" => lgd_paykey
      }

      resp = HTTParty.post(url, body: post_body)
      Return.new(lgd_mid, resp.parsed_response)
    end

    private

    def lgd_mid
      config.lgd_mid
    end

    def txname
      @txname ||= "PaymentByKey"
    end

    def tx_id
      return @tx_id if @tx_id
      now = Time.now.strftime("%Y%m%d%H%M%S")
      header = lgd_mid + "-" + config.server_id + now
      @tx_id = header + Digest::SHA1.hexdigest(get_unique)
    end

    def auth_code
      Digest::SHA1.hexdigest(tx_id + config.mertkey(lgd_mid))
    end

    def get_unique
      SecureRandom.hex(13)
    end

    def url
      config.url(cst_platform)
    end

    def config
      Configuration
    end

    def normalize_options!(options)
      options.keys.each do |key|
        options[(key.downcase.to_sym rescue key.downcase) || key] = options.delete(key)
      end
      options
    end
  end
end