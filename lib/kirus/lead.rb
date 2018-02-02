require 'active_resource'
module Kirus
  class Lead < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :company_market, class_name: "Kirus::CompanyMarket"
    belongs_to :user, class_name: "Kirus::User"
    belongs_to :company, class_name: "Kirus::Company"
    belongs_to :shipping_address, class_name: "Kirus::Address"
    belongs_to :billing_address, class_name: "Kirus::Address"
    has_many :notes, class_name: "Kirus::Note"
    # accepts_nested_attributes_for :notes, reject_if: :all_blank, allow_destroy: true
    has_many :lead_orders, class_name: "Kirus::LeadOrder"
    has_many :orders, class_name: "Kirus::Order"
  end
end
