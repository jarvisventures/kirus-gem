require 'active_resource'
module Kirus
  class Market < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    has_many :company_markets, class_name: "Kirus::CompanyMarket"
    has_many :companies, class_name: "Kirus::Company"

    def test
      debugger
    end
  end
end
