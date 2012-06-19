require 'test_helper'

class TopControllerTest < ActionController::TestCase
  test "should get top_specialist" do
    get :top_specialist
    assert_response :success
  end

end
