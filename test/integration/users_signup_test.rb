require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { first_name: "", last_name: "", email: "user@invalid", address_line_1: "222 W Hargett St", city: "Raleigh", zip_code: 27601, password: "foo", password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { first_name: "Example", last_name: "User", email: "user@example.com", organization: "Lush Bull City", address_line_1: "101 City Hall Plaza", city: "Durham", zip_code: 27701, password: "foobar", password_confirmation: "foobar" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
