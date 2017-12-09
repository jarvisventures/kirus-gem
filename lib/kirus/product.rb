module Kirus
  class Product
    attr_reader :id, :name, :description, :price, :available_on, :discontinue_on, :deleted_at, :slug, :meta_description, :promotionable, :meta_title, :total_on_hand, :variants, :product_images, :category
    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @description = attributes["description"]
      @slug = attributes["slug"]
      @available_on = attributes["available_on"]
      @discontinue_on = attributes["discontinue_on"]
      @deleted_at = attributes["deleted_at"]
      @meta_description = attributes["meta_description"]
      @promotionable = attributes["promotionable"]
      @meta_title = attributes["meta_title"]
      @price = attributes["current_price"]
      @total_on_hand = attributes["total_on_hand"]
      @variants = attributes["variants_including_master"].map { |attributes| Kirus::Variant.new(attributes) }
      @product_images = attributes["product_images"]
      @category = attributes["category"]
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/products/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      if response.status == 200 && response.body != "null"
        attributes = JSON.parse(response.body)
        new(attributes)
      elsif response.status == 200 && response.body == "null"
        nil
      elsif response.status == 401
        nil
      elsif response.status == 404
        nil
      end
    end

    def self.all
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/products" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      if response.status == 200 && response.body != "null"
        products = JSON.parse(response.body)
        products.map { |attributes| new(attributes) }
      elsif response.status == 200 && response.body == "null"
        []
      elsif response.status == 401
        []
      elsif response.status == 404
        []
      elsif response.status == 500
        []
      end
    end

    def image_s
      self.product_images.first.present? ? self.product_images.first["image"]["small"]["url"] : false
    end

    def image_m
      self.product_images.first.present? ? self.product_images.first["image"]["medium"]["url"] : false
    end

    def image_l
      self.product_images.first.present? ? self.product_images.first["image"]["large"]["url"] : false
    end

    def image_xl
      self.product_images.first.present? ? self.product_images.first["image"]["xlarge"]["url"] : false
    end

    def self.first
      self.all.first
    end

    def self.second
      self.all.second
    end

    def self.third
      self.all.third
    end

    def self.last
      self.all.last
    end
  end
end
