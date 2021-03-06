require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_select "form[action='/signup']"

    assert_no_difference("User.count") do
      post signup_path, params: { user:
        { name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"}
      }
    end

    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert.alert-danger"
    assert_select "div.field_with_errors"

    assert_select "ul.errors_ul" do
      assert_select "li", "Name can't be blank"
      assert_select "li", "Email is invalid"
      assert_select "li", "Password is too short (minimum is 6 characters)"
      assert_select "li", "Password confirmation doesn't match Password"
    end
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_select "form[action='/signup']"

    assert_difference("User.count", 1) do
      post signup_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    user = assigns(:user)
    assert_redirected_to root_url
    follow_redirect!
    assert_template "static_pages/home"
    assert_not flash.empty?
    assert flash[:info]
    assert_select "div.alert.alert-info", "Please check your email to activate your account."
    assert_not is_logged_in?

    assert_equal 1, ActionMailer::Base.deliveries.size

    log_in_as(user)
    assert_not is_logged_in?

    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?


  end

end
