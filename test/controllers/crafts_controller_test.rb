require 'test_helper'

class CraftsControllerTest < ActionController::TestCase
  setup do
    @craft = crafts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crafts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create craft" do
    assert_difference('Craft.count') do
      post :create, craft: { PriceDet_id: @craft.PriceDet_id, availability: @craft.availability, brand_id: @craft.brand_id, category: @craft.category, name: @craft.name, price_determinant: @craft.price_determinant, prod_desc: @craft.prod_desc, quantity: @craft.quantity, user_id: @craft.user_id }
    end

    assert_redirected_to craft_path(assigns(:craft))
  end

  test "should show craft" do
    get :show, id: @craft
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @craft
    assert_response :success
  end

  test "should update craft" do
    patch :update, id: @craft, craft: { PriceDet_id: @craft.PriceDet_id, availability: @craft.availability, brand_id: @craft.brand_id, category: @craft.category, name: @craft.name, price_determinant: @craft.price_determinant, prod_desc: @craft.prod_desc, quantity: @craft.quantity, user_id: @craft.user_id }
    assert_redirected_to craft_path(assigns(:craft))
  end

  test "should destroy craft" do
    assert_difference('Craft.count', -1) do
      delete :destroy, id: @craft
    end

    assert_redirected_to crafts_path
  end
end
