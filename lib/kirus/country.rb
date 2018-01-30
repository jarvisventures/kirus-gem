require 'active_resource'
module Kirus
  class Country < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    has_many :states
    belongs_to :market

    def self.country_list_for_dropdown
      country_list = Array.new
      self.all.each { |country| country_list << [country.name, country.id] }
      return country_list.sort
    end
  end
end
