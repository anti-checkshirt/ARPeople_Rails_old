require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get service" do
    get main_service_url
    assert_response :success
  end

  test "should get privacy" do
    get main_privacy_url
    assert_response :success
  end

end
