require 'test_helper'

class CompinfosControllerTest < ActionController::TestCase
  setup do
    @compinfo = compinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compinfo" do
    assert_difference('Compinfo.count') do
      post :create, compinfo: { content: @compinfo.content, creator: @compinfo.creator, title: @compinfo.title, type: @compinfo.type }
    end

    assert_redirected_to compinfo_path(assigns(:compinfo))
  end

  test "should show compinfo" do
    get :show, id: @compinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @compinfo
    assert_response :success
  end

  test "should update compinfo" do
    patch :update, id: @compinfo, compinfo: { content: @compinfo.content, creator: @compinfo.creator, title: @compinfo.title, type: @compinfo.type }
    assert_redirected_to compinfo_path(assigns(:compinfo))
  end

  test "should destroy compinfo" do
    assert_difference('Compinfo.count', -1) do
      delete :destroy, id: @compinfo
    end

    assert_redirected_to compinfos_path
  end
end
