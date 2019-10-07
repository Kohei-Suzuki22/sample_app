require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
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


end
