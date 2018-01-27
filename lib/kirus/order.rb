require 'active_resource'
module Kirus
  class Order < ActiveResource::Base
    self.site = API_URL
    self.headers['Authorization'] = "Token token=#{TOKEN}"
    self.headers['X-API-KEY'] = API_KEY

    # belongs_to :shipping_address, class_name: "Kirus::Address", optional: true
    # belongs_to :billing_address, class_name: "Kirus::Address", optional: true
    # belongs_to :seller, class_name: "Kirus::User", optional: true
    # belongs_to :buyer, class_name: "Kirus::User", optional: true
    # belongs_to :approver, class_name: "Kirus::User", optional: true
    # belongs_to :canceler, class_name: "Kirus::User", optional: true
    # belongs_to :created_by, class_name: "Kirus::User", optional: true
    belongs_to :company, class_name: "Kirus::Company"
    belongs_to :company_market, class_name: "Kirus::CompanyMarket"
    has_one :market, class_name: "Kirus::Market"
    has_many :order_items, class_name: "Kirus::OrderItem"
    has_many :variants, class_name: "Kirus::Variant"
    has_many :lead_orders, class_name: "Kirus::LeadOrder"

    # New update method that should maybe replace the old one????
    def update_order(order_info)
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end

      response = conn.patch "/orders/#{self.id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = order_info.to_json
      end
    end

    # Returns a nice string of the shipping address
    def get_shipping_address
      str = ""
      if self.shipping_address
        str << self.shipping_address.address1 + " "
        str << self.shipping_address.address2 + " " if self.shipping_address.address2.present?
        str << self.shipping_address.city + ", "
        str << self.shipping_address.state_abbr + " "
        str << self.shipping_address.zipcode
      else
        str = "No shipping address found"
      end
      str
    end

    # Returns a nice string of the billing address
    def get_billing_address
      str = ""
      if self.billing_address
        str << self.billing_address.address1 + " "
        str << self.billing_address.address2 + " " if self.billing_address.address2.present?
        str << self.billing_address.city + ", "
        str << self.billing_address.state_abbr + " "
        str << self.billing_address.zipcode
        str = "Same as shipping address" if str == self.get_shipping_address
      else
        str = "No billing address found"
      end
      str
    end

    def authorize_payment(attributes)
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.post "/orders/#{self.id}/authorize_payment" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = attributes
      end
      output(response)
    end

    def complete
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.post "/orders/#{self.id}/complete_order" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end
      output(response)
    end

    private

    def output(response)
      output = Hash.new
      output[:status] = response.status
      output[:response] = response.body

      output
    end

    def self.output(response)
      output = Hash.new
      output[:status] = response.status
      output[:response] = response.body

      output
    end
  end
end
