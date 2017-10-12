require './test/test_helper'

class KirusUserTest < Minitest::Test
  def test_exists
    assert Kirus::User
  end

  def test_it_gives_back_a_single_user
    user = Kirus::User.find(298486374)
    assert_equal Kirus::User, user.class

    assert_equal 298486374, user.id
    assert_equal "Rep", user.first_name
    assert_equal "Reppy", user.last_name
  end

  def test_it_gives_back_all_users
    result = Kirus::User.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::User)
  end
end
