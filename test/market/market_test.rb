require './test/test_helper'

class KirusMarketTest < Minitest::Test
  def test_exists
    assert Kirus::Admin::Market
  end

  def test_it_gives_back_a_single_market
    market = Kirus::Admin::Market.find(298486374)
    assert_equal Kirus::Admin::Market, market.class

    assert_equal 298486374, market.id
    assert_equal "EU_VAT", market.name
    assert_equal "Countries that make up the EU VAT zone.", market.description
  end

  def test_it_gives_back_all_markets
    result = Kirus::Admin::Market.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Admin::Market)
  end

  # def test_it_deletes_a_market
  #   result = Kirus::Admin::Market.first.delete
  #
  #   assert result[:status] == 200
  #   refute_nil result
  # end

  def test_it_updates_a_market
    result = Kirus::Admin::Market.first.update(name: 'seth')

    assert_equal "seth", result[:response]["name"]
    assert result[:status] == 200
    refute_nil result
  end
end
