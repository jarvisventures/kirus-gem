require 'active_resource'
module Kirus
  class Address < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :state, class_name: "Kirus::State"
    belongs_to :country, class_name: "Kirus::Country"
    belongs_to :user, class_name: "Kirus::User"
    # has_many :credit_cards

  end
end
