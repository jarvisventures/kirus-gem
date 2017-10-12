require './test/test_helper'
require 'date'

class KirusProductTest < Minitest::Test
  def test_exists
    assert Kirus::Product
  end

  def test_it_gives_back_a_single_product
    product = Kirus::Product.find(298486374)
    assert_equal Kirus::Product, product.class

    assert_equal 298486374, product.id
    assert_equal "MyString", product.name
    assert_equal "MyText", product.description
    assert (DateTime.parse(product.available_on) rescue nil).is_a?(DateTime)
  end

  def test_it_gives_back_all_products
    result = Kirus::Product.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Product)
  end
end
