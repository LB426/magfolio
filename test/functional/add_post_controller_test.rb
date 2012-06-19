require 'test_helper'

class AddPostControllerTest < ActionController::TestCase
  test "should get add_mnenie" do
    get :add_mnenie
    assert_response :success
  end

  test "should get add_akciya" do
    get :add_akciya
    assert_response :success
  end

  test "should get add_presentation" do
    get :add_presentation
    assert_response :success
  end

end
