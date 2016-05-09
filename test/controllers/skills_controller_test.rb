require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  test "should get pruning" do
    get :pruning
    assert_response :success
  end

  test "should get grafting" do
    get :grafting
    assert_response :success
  end

end
