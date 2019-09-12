require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path, text: "Help"
    assert_select "a[href=?]", about_path, text: "About"
    assert_select "a[href=?]", contact_path, text: "Contact"
    assert_select "h1", "Welcome to the Sample App"

    get contact_path
    assert_response :success

    get signup_path
    assert_response :success
  end
end