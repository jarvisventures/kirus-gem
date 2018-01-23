API_URL = "http://localhost:3000"
TOKEN = "gHxPG7BshnOe9T"
API_KEY = "Oe9TmTPW3C"

require 'kirus/version'
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'ostruct'

require 'kirus/admin/market'
require 'kirus/admin/user'
require 'kirus/cart'
require 'kirus/category'
require 'kirus/company'
require 'kirus/order'
require 'kirus/product'
require 'kirus/variant'
require 'kirus/state'
require 'kirus/country'
require 'kirus/lead'
require 'kirus/company_market'
require 'kirus/market'

# API_URL = "https://kirus-api-staging.herokuapp.com"

module Kirus
  def make_request(method, path)
    # conn = Faraday.new(:url => API_URL)
    # response = conn.delete "/admin/users/#{self.id}" do |request|
    #   request.headers['Content-Type'] = 'application/json'
    #
    # end
    # # TODO
  end
end
