require 'active_resource'
module Kirus
  module Admin
    class Market < ActiveResource::Base
      self.site = API_URL
      self.headers['Authorization'] = "Token token=#{TOKEN}"
      self.headers['X-API-KEY'] = API_KEY
    end
  end
end
