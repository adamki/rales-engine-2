require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    item_count = Item.count
    get :index, format: :json

    assert_response :success
    assert_equal item_count, json_response.count
  end

  test "#show" do
    item = items(:one)
    get :show, id: item.id, format: :json

    assert_response :success 
    assert_equal "Item Qui Esse", json_response["name"]
    assert_equal "Some Description", json_response["description"]
    assert_equal 1037692251, json_response["merchant_id"]
  end

  test "#find" do
    get :find, name: "item qui esse", format: :json

    assert_response :success
    assert_equal "Some Description", json_response["description"]
  end

  test "#find_all" do
    item = Item.create(name: "test item",
                       description: "test description",
                       unit_price: 49995)

    item_2 = Item.create(name: "test item",
                                      description: "test description",
                                      unit_price: 49995)
    
    invoice_item = InvoiceItem.create(quantity: 12,
                                      unit_price: 49995,
                                      item_id: item.id)

    get :find_all, name: item.name, format: :json

    assert_response :success
    assert_equal "test description", json_response.first["description"]
  end
end
