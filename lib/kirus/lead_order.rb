require 'active_resource'
module Kirus
  class LeadOrder < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    belongs_to :lead, class_name: "Kirus::Lead"
    belongs_to :order, class_name: "Kirus::Order"

    def blastoise
      conn = Faraday.new(url: API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      response = conn.post "/lead_orders/#{self.id}/blastoise" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      if response.status == 201 && response.body != "null"
        attributes = JSON.parse(response.body.to_json)
        Kirus::Order.new(attributes)
      elsif response.status == 401
        nil
      elsif response.status == 404
        nil
      end
    end
  end


end
