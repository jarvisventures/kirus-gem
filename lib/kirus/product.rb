require 'active_resource'
module Kirus
  class Product < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY
    # self.include_root_in_json = false
    belongs_to :company
    belongs_to :category, class_name: "Kirus::Category"
    has_many :variants, class_name: "Kirus::Variant"
    # belongs_to :shipping_category
    # has_many :stocks
    # has_many :warehouses
    # has_many :markets
    # has_many :product_images

    def image_s
      self.product_images.first.present? ? self.product_images.first.image.small.url : false
    end

    def image_m
      self.product_images.first.present? ? self.product_images.first.image.medium.url : false
    end

    def image_l
      self.product_images.first.present? ? self.product_images.first.image.large.url : false
    end

    def image_xl
      self.product_images.first.present? ? self.product_images.first.image.xlarge.url : false
    end
  end
end
