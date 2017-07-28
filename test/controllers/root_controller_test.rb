require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_index_url
    assert_response :success
  end

  test "should get about" do
    get root_about_url
    assert_response :success
  end

  test "should get contact" do
    get root_contact_url
    assert_response :success
  end

end
