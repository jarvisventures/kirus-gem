require 'active_resource'
module Kirus
  class Country < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    has_many :states
    belongs_to :market
  end
end
