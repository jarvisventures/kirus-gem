require 'active_resource'
module Kirus
  class Category < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    has_many :products
    belongs_to :company
  end
end
