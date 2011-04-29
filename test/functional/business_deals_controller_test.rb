require 'test_helper'

class BusinessDealsControllerTest < ActionController::TestCase
  setup do
    @business_deal = business_deals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_deals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_deal" do
    assert_difference('BusinessDeal.count') do
      post :create, :business_deal => @business_deal.attributes
    end

    assert_redirected_to business_deal_path(assigns(:business_deal))
  end

  test "should show business_deal" do
    get :show, :id => @business_deal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @business_deal.to_param
    assert_response :success
  end

  test "should update business_deal" do
    put :update, :id => @business_deal.to_param, :business_deal => @business_deal.attributes
    assert_redirected_to business_deal_path(assigns(:business_deal))
  end

  test "should destroy business_deal" do
    assert_difference('BusinessDeal.count', -1) do
      delete :destroy, :id => @business_deal.to_param
    end

    assert_redirected_to business_deals_path
  end
end
