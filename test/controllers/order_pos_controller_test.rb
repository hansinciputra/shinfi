require 'test_helper'

class OrderPosControllerTest < ActionController::TestCase
  setup do
    @order_po = order_pos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_pos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_po" do
    assert_difference('OrderPo.count') do
      post :create, order_po: {  }
    end

    assert_redirected_to order_po_path(assigns(:order_po))
  end

  test "should show order_po" do
    get :show, id: @order_po
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_po
    assert_response :success
  end

  test "should update order_po" do
    patch :update, id: @order_po, order_po: {  }
    assert_redirected_to order_po_path(assigns(:order_po))
  end

  test "should destroy order_po" do
    assert_difference('OrderPo.count', -1) do
      delete :destroy, id: @order_po
    end

    assert_redirected_to order_pos_path
  end
end
