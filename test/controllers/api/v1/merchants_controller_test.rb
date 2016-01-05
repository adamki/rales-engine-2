require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    merchant_count = Merchant.count
    get :index, format: :json

    assert_response :success
    assert_equal merchant_count, json_response.count
  end

  test "#show" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    assert_response :success
    assert_equal "adam", json_response["name"]
  end

  test "#find" do
    get :find, name: "adam", format: :json

    assert_response :success
    assert_equal "adam", json_response["name"]
    assert_equal 980190962, json_response["id"]
  end

  test "#find_all" do
    get :find_all,  name: "test-fixture", format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end
  
end
