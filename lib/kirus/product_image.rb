require 'active_resource'
module Kirus
  class ProductImage < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :variant, class_name: "Kirus::Variant"
    has_one :product, class_name: "Kirus::Product"
  end
end
