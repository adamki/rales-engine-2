class Api::V1::Invoices::ItemsControllerTest < ActionController::TestCase
  test "#index shows correct number of items" do 
    customer = Customer.create(first_name: "Ricky", last_name: "Bobby")
    merchant = Merchant.create(name: "Damm Music Center")
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id, status: "incomplete")
    item = Item.create(name: "Guitar", 
                       description: "Electric", 
                       unit_price: 100,
                       merchant_id: merchant.id)
    item2 = Item.create(name: "Bass", 
                        description: "Upright", 
                        unit_price: 200,
                        merchant_id: merchant.id)
    invoice_item1 = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id,
                                       quantity: 20, unit_price: 100)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 100,
                       unit_price: 2000)

    get :index, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_kind_of Array, json_response
    assert_equal 2, json_response.count
  end
end
