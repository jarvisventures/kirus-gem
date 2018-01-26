require 'active_resource'
module Kirus
  class OrderItem < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :order, class_name: "Kirus::Order"
    belongs_to :variant, class_name: "Kirus::Variant"
    # has_many :stocks
    # has_many :warehouses
    # has_many :option_value_variants
    # has_many :option_values
    # has_many :option_types
    # has_many :product_images
  end
end
