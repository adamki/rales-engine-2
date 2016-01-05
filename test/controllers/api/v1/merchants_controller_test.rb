require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    merchant_count = Merchant.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal merchant_count, json_response.count
  end

  test "#show" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal "adam", json_response["name"]
  end
end
