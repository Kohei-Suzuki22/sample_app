require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup_title_name
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "sould get root" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{setup_title_name}"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{setup_title_name}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{setup_title_name}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{setup_title_name}"
  end

  test "sould get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{setup_title_name}"
  end

end
