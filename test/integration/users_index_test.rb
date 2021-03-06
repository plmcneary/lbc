require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:peter)
    @non_admin = users(:megan)
  end

#Add pagination test to index eventually

  test "index as admin including delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    users = User.all
    users.each do |user|
      if user.activated
        assert_select 'a[href=?]', user_path(user), text: "#{user.first_name} #{user.last_name}"
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      else
        assert_select 'a[href=?]', user_path(user), text: "#{user.first_name} #{user.last_name}", count: 0
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
