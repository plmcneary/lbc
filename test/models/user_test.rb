require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", organization: "Lush Bull City", address_line_1: "101 City Hall Plaza", city: "Durham", zip_code: 27701, password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

# First Name

  test "first name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

# Last Name

  test "last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

# Email

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

# Organization

  test "organization should not be too long" do
    @user.organization = "a" * 101
    assert_not @user.valid?
  end

  test "organizations should be unique" do
    duplicate_user = @user.dup
    duplicate_user.organization = @user.organization.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

# Address Line 1

  test "address line 1 should be present" do
    @user.address_line_1 = "     "
    assert_not @user.valid?
  end

  test "address line 1 should not be too long" do
    @user.address_line_1 = "a" * 101
    assert_not @user.valid?
  end

# Address Line 2

  test "address line 2 should not be too long" do
    @user.address_line_2 = "a" * 101
    assert_not @user.valid?
  end

# City

  test "city should be present" do
    @user.city = "     "
    assert_not @user.valid?
  end

  test "city validation should accept valid cities" do
    valid_cities = ["Durham", "Chapel Hill", "Hillsborough"]
    valid_cities.each do |valid_city|
      @user.city = valid_city
      assert @user.valid?, "#{valid_city.inspect} should be valid"
    end
  end

  test "city validation should reject invalid cities" do
    invalid_cities = ["Raleigh", "Cary", "Pittsboro", "Bahama", "Mebane"]
    invalid_cities.each do |invalid_city|
      @user.email = invalid_city
      assert_not @user.valid?, "#{invalid_city.inspect} should be invalid"
    end
  end

# Zip Code

  test "zip code validation should accept valid zip codes" do
    valid_zip_codes = [27278, 27510, 27514, 27516, 27517, 27599, 27701, 27703, 27704, 27705, 27706, 27707, 27708, 27709, 27710, 27711, 27712, 27713]
    valid_zip_codes.each do |valid_zip_code|
      @user.zip_code = valid_zip_code
      assert @user.valid?, "#{valid_zip_code.inspect} should be valid"
    end
  end

  test "zip code validation should reject invalid zip codes" do
    invalid_zip_codes = [27231, 27234, 27302, 27312, 27503, 27509, 27519, 27522, 27523, 27541, 27560, 27572, 27587, 27613, 27617]
    invalid_zip_codes.each do |invalid_zip_code|
      @user.zip_code = invalid_zip_code
      assert_not @user.valid?, "#{invalid_zip_code.inspect} should be invalid"
    end
  end

# Password

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
