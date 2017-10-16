require 'kirus/version'
require 'faraday'
require 'faraday_middleware'
require 'json'

require 'kirus/category'
require 'kirus/company'
require 'kirus/market'
require 'kirus/order'
require 'kirus/product'
require 'kirus/admin/user'

API_URL = "http://localhost:3000"

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
