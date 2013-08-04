module UplusXpay
  class Configuration
    class << self
      attr_accessor :cst_mid, :lgd_mertkey, :server_id, :time_out, :urls, :mertkeys
    end

    def self.cst_platform=(platform)
      @cst_platform = platform
    end

    def self.cst_platform
      @cst_platform ||= Rails.env.production? ? 'service' : 'test'
    end

    def self.lgd_mid
      cst_platform == 'service' ? cst_mid : "t#{cst_mid}"
    end

    def self.mertkey(lgd_mid)
      mertkeys.fetch(lgd_mid.to_sym)
    end

    def self.url(cst_platform)
      case cst_platform
      when "service" then urls.fetch("url")
      when "test" then urls.fetch("test_url")
      end
    end


    def self.casnoteurl
      "..."
    end

    def lgd_kvpmispnoteurl
      "..."
    end

    def lgd_kvpmispwapurl
      "..."
    end

    def lgd_kvpmispcancelurl
      "..."
    end
  end
end