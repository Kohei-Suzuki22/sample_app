require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template "users/show"
    assert_select "title", full_title(@user.name)
    assert_select "h1", text: @user.name
    assert_select "h1>img.gravatar"
    assert_match @user.microposts.count.to_s, response.body
    assert_select "div ul.pagination", count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end

    assert_select "section.stats"
    assert_select "a[href=?]", followings_user_path(@user), count: 1 do
      assert_select "strong#followings.stat", text: "#{@user.followings.count}"
      assert_match  "followings", response.body
    end
    assert_select "a[href=?]", followers_user_path(@user), count: 1 do
      assert_select "strong#followers.stat", text: "#{@user.followers.count}"
      assert_match "followers", response.body
    end
    assert_select "div#follow_form", count: 0

    archer = users(:archer)

    get user_path(archer)
    assert_select "section.stats"
    assert_select "a[href=?]", followings_user_path(archer), count: 1 do
      assert_select "strong#followings.stat", text: "#{@user.followings.count}"
      assert_match  "followings", response.body
    end
    assert_select "a[href=?]", followers_user_path(archer), count: 1 do
      assert_select "strong#followers.stat", text: "#{@user.followers.count}"
      assert_match "followers", response.body
    end
    assert_template "users/show"
    assert_select "div#follow_form", count: 1
    assert_select "input[type=hidden][name=followed_id][value=?]", "#{archer.id}"
    assert_select "input[type=submit][value=?]", "Follow"

  end


end
