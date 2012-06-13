require 'test_helper'

class TopControllerTest < ActionController::TestCase
  test "should get top_mneniy" do
    get :top_mneniy
    assert_response :success
  end

  test "should get top_presentation" do
    get :top_presentation
    assert_response :success
  end

  test "should get top_catalogov" do
    get :top_catalogov
    assert_response :success
  end

  test "should get top_user" do
    get :top_user
    assert_response :success
  end

end
