require 'active_resource'
module Kirus
  class State < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :country, class_name: "Kirus::Country"

    private

  end
end
