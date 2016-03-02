require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCases

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", full_title()
  end

  test "should get about" do
    get :about
    assert_select "title", full_title("About")
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", full_title("Contact")
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
    assert_select "title", full_title("Privacy")
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", full_title("Help")
  end

  test "should get faq" do
    get :faq
    assert_response :success
    assert_select "title", full_title("FAQ")
  end

  test "should get copyright" do
    get :copyright
    assert_response :success
    assert_select "title", full_title("Copyright")
  end

  test "should get terms" do
    get :terms
    assert_response :success
    assert_select "title", full_title("Terms")
  end

end
