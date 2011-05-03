require 'test_helper'

class IzbrannoesControllerTest < ActionController::TestCase
  setup do
    @izbranno = izbrannoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:izbrannoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create izbranno" do
    assert_difference('Izbrannoe.count') do
      post :create, :izbranno => @izbranno.attributes
    end

    assert_redirected_to izbranno_path(assigns(:izbranno))
  end

  test "should show izbranno" do
    get :show, :id => @izbranno.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @izbranno.to_param
    assert_response :success
  end

  test "should update izbranno" do
    put :update, :id => @izbranno.to_param, :izbranno => @izbranno.attributes
    assert_redirected_to izbranno_path(assigns(:izbranno))
  end

  test "should destroy izbranno" do
    assert_difference('Izbrannoe.count', -1) do
      delete :destroy, :id => @izbranno.to_param
    end

    assert_redirected_to izbrannoes_path
  end
end
