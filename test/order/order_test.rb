require './test/test_helper'

class KirusOrderTest < Minitest::Test
  def test_exists
    assert Kirus::Order
  end

  def test_it_gives_back_a_single_order
    order = Kirus::Order.find(980190962)
    assert_equal Kirus::Order, order.class

    assert_equal 980190962, order.id
    assert_equal "MyString", order.number
  end

  def test_it_gives_back_all_orders
    result = Kirus::Order.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Order)
  end

  # def test_it_deletes_a_order
  #   result = Kirus::Order.first.delete
  #
  #   assert result[:status] == 200
  #   refute_nil result
  # end

  def test_it_updates_a_order
    result = Kirus::Order.first.update(number: 'seth')

    assert_equal "seth", result[:response]["number"]
    assert result[:status] == 200
    refute_nil result
  end
end
