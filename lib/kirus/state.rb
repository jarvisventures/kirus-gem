require 'active_resource'
module Kirus
  class State < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :country, class_name: "Kirus::Country"

    def self.state_list_for_dropdown
      state_list = Array.new
      self.all.each { |state| state_list << [state.abbr, state.abbr] }
      return state_list.sort
    end
  end
end
