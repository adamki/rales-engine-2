require 'test_helper'

class Api::V1::Items::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index returns a collection of associated invoice items" do
    skip
    item = Item.create(name: "test item",
                       unit_price: "234.93",
                       description: "test description")

    invoice_item = InvoiceItem.create(item_id: item.id,
                                      quantity: 1,
                                      unit_price: "123.33")

    invoice_item_two = InvoiceItem.create(item_id: item.id,
                                      quantity: 1,
                                      unit_price: "1112.82")

    invoice_item_three = InvoiceItem.create(item_id: item.id,
                                      quantity: 1,
                                      unit_price: "9.82")
    get :index, id: item.id, format: :json
    assert_response :success
    assert_equal 3, json_response.count
    assert_equal invoice_item[:unit_price], json_response.first["unit_price"]
    assert_equal invoice_item_two[:unit_price], json_response.second["unit_price"]
    assert_equal invoice_item_three[:unit_price], json_response.third["unit_price"]
  end
end
