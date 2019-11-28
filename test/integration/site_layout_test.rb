require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links when not logged in" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path, text: "Help"
    assert_select "a[href=?]", about_path, text: "About"
    assert_select "a[href=?]", contact_path, text: "Contact"
    assert_select "h1", "Welcome to the Sample App"

    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0

    get contact_path
    assert_response :success

    get signup_path
    assert_response :success
  end

  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path, text: "Help"
    assert_select "a[href=?]", about_path, text: "About"
    assert_select "a[href=?]", contact_path, text: "Contact"

    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0

    assert_select "a[href=?]", followings_user_path(@user) do
      assert_select "strong#followings.stat", text: "#{@user.followings.count}"
      assert_match "followings", response.body
    end
    assert_select "a[href=?]", followers_user_path(@user) do
      assert_select "strong#followers.stat", text: "#{@user.followings.count}"
      assert_match "followers", response.body
    end


    get contact_path
    assert_response :success

    get signup_path
    assert_response :success
  end

end
