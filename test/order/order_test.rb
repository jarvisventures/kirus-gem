require './test/test_helper'

class KirusOrderTest < Minitest::Test
  def test_exists
    assert Kirus::Order
  end

  def test_it_creates_an_order
    response = Kirus::Order.create(company_id: 98190962, number: "12345", item_total: 1.5, total: 1.5, state: 'UT', adjustment_total: 1.5, completed_at: Time.now, payment_total: 1.5,
      shipment_state: "String", payment_state: "String", email: "adam@example.com", special_instructions: "none", currency: "my string", shipment_total: 1.5, additional_tax_total: 1.5,
    promo_total: 1.5, included_tax_total: 1.5, item_count: 1, approved_at: Time.now, confirmation_email: Time.now, token: "string", cart_expiration: Time.now + 100, save_card: 0)

    assert_equal response[:status], 201
  end

  def test_it_gives_back_a_single_order
    order = Kirus::Order.find(980190962)
    assert_equal Kirus::Order, order.class

    assert_equal 980190962, order.id
  end
end
