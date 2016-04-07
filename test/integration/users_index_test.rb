require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:peter)
  end

#Add pagination test to index eventually

  test "index" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  end
end
