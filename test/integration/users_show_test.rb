require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @non_activated = users(:jason)
  end

  test "should not show inactive users" do
    get user_path(@non_activated)
    assert_response :redirect
  end
end
