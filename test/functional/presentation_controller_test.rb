require 'test_helper'

class PresentationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get reserv_page1" do
    get :reserv_page1
    assert_response :success
  end

  test "should get reserv_page2" do
    get :reserv_page2
    assert_response :success
  end

  test "should get reserv_page3" do
    get :reserv_page3
    assert_response :success
  end

end
