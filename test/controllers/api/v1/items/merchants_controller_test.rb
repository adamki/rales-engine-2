require 'test_helper'

class Api::V1::Items::MerchantsControllerTest < ActionController::TestCase
  test "#show returns the associated merchant for a given item" do
    merchant = Merchant.create(name: "SubPop Records")

    item = Item.create(name: "Sunset Rubdown", 
                       description: "Magical music by Spencer Krug",
                       unit_price: 1299,
                       merchant_id: merchant.id)

    get :show, id: item.id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal merchant[:name], json_response["name"]
  end
end
