require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_redirected_to(login_url)
    follow_redirect!
    assert_not flash.empty?
    log_in_as(@user)
    get edit_user_path(@user)
    assert_select "form[action='user_path(@user)']", count: 0
    assert_select "form[action='#{edit_user_path(@user)}']"
    assert_template "users/edit"

    patch edit_user_path(@user), params:{
      user:{
        name: "",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    }

    assert_template "users/edit"
    assert_select "div#error_explanation"
    assert_select "ul.errors_ul li", count: 4
    assert_select "div.alert.alert-danger", text: "The form contains 4 errors"

  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_redirected_to(login_url)
    follow_redirect!
    assert_not flash.empty?
    log_in_as(@user)
    get edit_user_path(@user)
    assert_select "form[action='#{edit_user_path(@user)}']"
    assert_template "users/edit"
    name = "Foo Bar"
    email = "foo@bar.com"

    patch edit_user_path(@user),params:{
      user:{
        name: name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }

    assert_not flash.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email

  end


end
