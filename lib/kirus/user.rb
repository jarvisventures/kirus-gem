require 'active_resource'
module Kirus
  class User < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    has_many :leads, class_name: "Kirus::Lead"
  end
end
