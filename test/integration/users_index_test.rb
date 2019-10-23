require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @non_activated = users(:bob)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "ul.pagination", count: 2

    first_page_of_users = User.where(activated: true).paginate(page: 1, per_page: 20)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert_select "a[href=?]", user_path(user), text: "delete" unless user == @admin
      assert user.activated?
    end
    assert_select "a[href=?]", user_path(@admin), text: "delete", count: 0
    assert_select "a[href=?]", user_path(@non_activated), count: 0
    assert_select @non_activated.name, count: 0

    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
    end

  end

  test "index as non_admin" do

    log_in_as(@non_admin)
    get users_path
    first_page_of_users = User.where(activated: true).paginate(page: 1, per_page: 20)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert user_path(@non_admin)
    end
    assert_select 'a', text: "delete", count: 0
    assert_select "a[href=?]", user_path(@non_activated), count: 0
    assert_select @non_activated.name, count: 0
  end

end
