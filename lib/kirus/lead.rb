require 'active_resource'
module Kirus
  class Lead < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    # belongs_to :company_market
    # belongs_to :user
    # belongs_to :company
    # # belongs_to :shipping_address
    # # belongs_to :billing_address
    # has_many :notes
    # has_many :lead_orders
    # has_many :orders
  end
end
