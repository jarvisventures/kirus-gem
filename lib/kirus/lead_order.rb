require 'active_resource'
module Kirus
  class LeadOrder < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :lead
    belongs_to :order
  end
end
