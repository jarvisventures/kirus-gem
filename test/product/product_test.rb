require './test/test_helper'
require 'date'

class KirusProductTest < Minitest::Test
  def test_exists
    assert Kirus::Product
  end

  def test_it_gives_back_a_single_product
    product = Kirus::Product.find(980190962)
    assert_equal Kirus::Product, product.class

    assert_equal 980190962, product.id
    assert_equal "Nuku Hiva Juice", product.name
    assert_equal "Juice from the nectar of the gods.  Straight from Japan's deserts.", product.description
    assert (DateTime.parse(product.available_on) rescue nil).is_a?(DateTime)
  end

  def test_it_responds_to_product_not_found
    product = Kirus::Product.find(-1)

    assert_nil product
  end

  def test_it_gives_back_all_products
    products = Kirus::Product.all

    assert products.kind_of?(Array)
    assert products.first.kind_of?(Kirus::Product)
  end

  def test_it_has_at_least_one_variant
    product = Kirus::Product.find(980190962)
    assert_equal Kirus::Product, product.class

    assert product.variants.first.kind_of?(Kirus::Variant)
  end
end
