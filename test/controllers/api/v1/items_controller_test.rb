require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    item_count = Item.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal item_count, json_response.count
  end

  test "#show" do
    item = items(:one)
    get :show, id: item.id, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success 
    assert_equal "Item Qui Esse", json_response["name"]
    assert_equal "Some Description", json_response["description"]
    assert_equal "1", json_response["merchant_id"]
  end

  test "#find" do
    get :find, name: "item qui esse", format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal "Some Description", json_response["description"]
  end
end
