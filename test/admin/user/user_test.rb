require './test/test_helper'

class KirusUserTest < Minitest::Test
  def test_exists
    assert Kirus::Admin::User
  end

  # TODO add test fixtures, look into VCR / cassette stuffs
  def test_it_gives_back_a_single_user
    user = Kirus::Admin::User.find(298486374)
    assert_equal Kirus::Admin::User, user.class

    assert_equal 298486374, user.id
    assert_equal "seth", user.first_name
    assert_equal "Reppy", user.last_name
  end

  def test_it_gives_back_all_users
    result = Kirus::Admin::User.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Admin::User)
  end

  # def test_it_deletes_a_user
  #   result = Kirus::Admin::User.first.delete
  #
  #   assert result[:status] == 200
  #   refute_nil result
  # end

  def test_it_updates_a_user
    result = Kirus::Admin::User.first.update(first_name: 'seth')

    assert_equal "seth", result[:response]["first_name"]
    assert result[:status] == 200
    refute_nil result
  end
end
