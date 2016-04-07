require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:peter)
  end

  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", privacy_path
    assert_select "a[href=?]", faq_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", copyright_path
    assert_select "a[href=?]", terms_path
    get signup_path
    assert_select "title", full_title("Sign Up")
  end

  test "layout links when not logged in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0    
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", privacy_path
    assert_select "a[href=?]", faq_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", copyright_path
    assert_select "a[href=?]", terms_path
    get signup_path
    assert_select "title", full_title("Sign Up")
  end
end
