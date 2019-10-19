require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest

  test "should get edit" do
    user = users(:michael)
    get edit_account_activation_url(user)
    assert_response :redirect
  end

end
