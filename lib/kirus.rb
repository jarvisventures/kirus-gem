# API_URL = "http://localhost:3000"
API_URL = "https://kirus-api-staging.herokuapp.com"
TOKEN = "gHxPG7BshnOe9T"
API_KEY = "Oe9TmTPW3C"

require 'kirus/version'
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'ostruct'

require 'kirus/address'
require 'kirus/cart'
require 'kirus/category'
require 'kirus/company_market'
require 'kirus/company'
require 'kirus/country'
require 'kirus/lead_order'
require 'kirus/lead'
require 'kirus/market'
require 'kirus/order_item'
require 'kirus/order'
require 'kirus/product'
require 'kirus/product_image'
require 'kirus/state'
require 'kirus/user'
require 'kirus/variant'


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
