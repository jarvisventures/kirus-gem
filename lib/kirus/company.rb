require 'active_resource'
module Kirus
  class Company < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    # belongs_to :address, optional: true
    # has_many :company_markets
    # has_many :markets
    # has_many :warehouses
    # has_many :users
    # has_many :products
    # has_many :categories
    # has_many :option_types
    # has_many :option_val
    # has_many :payment_methods
    # has_many :shipping_categories
    # has_many :shipping_methods
    # has_many :shipments
  end
end
