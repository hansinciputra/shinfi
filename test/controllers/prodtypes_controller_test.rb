require 'test_helper'

class ProdtypesControllerTest < ActionController::TestCase
  setup do
    @prodtype = prodtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prodtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prodtype" do
    assert_difference('Prodtype.count') do
      post :create, prodtype: {  }
    end

    assert_redirected_to prodtype_path(assigns(:prodtype))
  end

  test "should show prodtype" do
    get :show, id: @prodtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prodtype
    assert_response :success
  end

  test "should update prodtype" do
    patch :update, id: @prodtype, prodtype: {  }
    assert_redirected_to prodtype_path(assigns(:prodtype))
  end

  test "should destroy prodtype" do
    assert_difference('Prodtype.count', -1) do
      delete :destroy, id: @prodtype
    end

    assert_redirected_to prodtypes_path
  end
end
