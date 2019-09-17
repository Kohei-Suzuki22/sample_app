require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user:
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
    assert_select "ul" do
      assert_select "li"
    end

    # assert_select 'div#CSS id for error explanation '
    # assert_select "div.<CSS class for field_with_errors>"
  end

end
