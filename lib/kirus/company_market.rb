require 'active_resource'
module Kirus
  class CompanyMarket < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :company, class_name: "Kirus::Company"
    belongs_to :market, class_name: "Kirus::Market"
  end
end
