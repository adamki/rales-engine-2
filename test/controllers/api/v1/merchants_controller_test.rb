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

  test "#favorite_customer returns a customer for a given merchant" do
    customer = Customer.create(first_name: "Jhun", last_name: "bug")
    rei = Merchant.create(name: "REI")

    invoice_1 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    invoice_2 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    get :favorite_customer, id: rei.id, format: :json

    assert_response :success
    assert_equal "Jhun", json_response["first_name"]
  end

  test "#customers_with_pending_invoices returns a collection of of customers" do
    rei = Merchant.create(name: "REI")

    #success
    juhn = Customer.create(first_name: "Jhun", last_name: "bug")

    invoice_1 = Invoice.create(customer_id: juhn.id,
                             merchant_id: rei.id,
                             status: "shipped")

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    #failed
    adam = Customer.create(first_name: "Adam", last_name: "bug")
    invoice_2 = Invoice.create(customer_id: adam.id,
                             merchant_id: rei.id,
                             status: "shipped")
    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "failed",
                                       invoice_id: invoice_2.id)

    get :customers_with_pending_invoices, id: rei.id, format: :json

    assert_response :success
    assert_equal 1, json_response.count
    assert_kind_of Array, json_response
    assert_equal "Adam", json_response.first["first_name"]
    assert_equal "Adam", json_response.first["first_name"]
  end

  test "#revenue returns total revenue for that merchant across all transactions" do
    customer = Customer.create(first_name: "Jhun", last_name: "bug")
    rei = Merchant.create(name: "REI")

    invoice_1 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    invoice_2 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    get :total_revenue, id: rei.id, format: :json

    assert_response :success
    assert_equal "0.0", json_response["total_revenue"]
  end

  test "#revenue returns total amount for a given merchant on a given date" do
    customer = Customer.create(first_name: "Jhun", last_name: "bug")
    rei = Merchant.create(name: "REI")

    invoice_1 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped",
                              created_at: "2012-03-16 11:55:05")

    invoice_2 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped",
                              created_at: "2012-03-16 11:55:05" )

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id,
                                       created_at: "2012-03-16 11:55:05")


    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id,
                                       created_at: "2012-03-16 11:55:05")

    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id,
                                       created_at: "2012-03-16 11:55:05")


    item = Item.create(name: "winter gloves",
                       description: "Warm enough for you",
                       unit_price: 1999)

    invoice_item = InvoiceItem.create(item_id: item.id,
                                      invoice_id: invoice_1.id,
                                      quantity: 2,
                                      unit_price: 19999)


    get :revenue, id: rei.id, date: "2012-03-16 11:55:05", format: :json

    assert_response :success
    assert_equal "1199.94", json_response["revenue"]
  end
end
