require 'test_helper'

class UserpgControllerTest < ActionController::TestCase
  test "should get user1" do
    get :user1
    assert_response :success
  end

end
