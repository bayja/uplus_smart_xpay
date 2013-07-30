module UplusXpay
  class Configuration
    class << self
      attr_accessor :cst_mid, :lgd_mertkey, :server_id, :time_out, :urls, :lgd_mid_values
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

    def self.lgd_mid_value(lgd_mid)
      lgd_mid_values.fetch(lgd_mid.to_sym)
    end

    def self.url(cst_platform)
      urls.fetch(cst_platform.to_sym)
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