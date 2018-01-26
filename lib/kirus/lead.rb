require 'active_resource'
module Kirus
  class Lead < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :company_market, class_name: "Kirus::CompanyMarket"
    # belongs_to :user
    belongs_to :company, class_name: "Kirus::Company"
    # # belongs_to :shipping_address
    # # belongs_to :billing_address
    # has_many :notes
    has_many :lead_orders, class_name: "Kirus::LeadOrder"
    has_many :orders, class_name: "Kirus::Order"
  end
end
