require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get index with logged in" do
    log_in_as(@user)
    get users_path
    assert_template "users/index"
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", full_title("Sign up")
  end

  test "get edit should redirect login_url when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to(login_url)
  end

  test "patch update should redirect login_url when not logged in" do
    patch edit_user_path(@user), params:{
      user:{
        name: @user.name,
        email: @user.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to(login_url)

  end

  test "get edit should redirect to root_url when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "patch update should redirect root_url when logged in as wrong user" do
    log_in_as(@other_user)
    patch edit_user_path(@user), params:{
      user:{
        name: @user.name,
        email: @user.email
      }
    }
    assert flash.empty?
    assert_redirected_to root_url


  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch edit_user_path(@other_user), params:{
      user:{
        password: "",
        password_confirmation: "",
        admin: true
      }
    }
    assert_not @other_user.reload.admin?

  end

  test "destroy should redirect login_url when not logged in" do
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "destroy should redirect root_url when logged in as a non_admin" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should destroy with admin_user" do
    log_in_as(@user)
    delete_target_user = users(:lana)
    assert_difference "User.count", -1 do
      delete user_path(delete_target_user)
    end
    assert_redirected_to users_path
  end


end
