require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_activated = users(:bob)
  end

  test "show as activated user" do
    log_in_as(@admin)
    get user_path(@admin)
    assert_template "users/show"

    get user_path(@non_activated)
    assert_redirected_to root_url
    follow_redirect!
    assert_template "static_pages/home"

  end

end
