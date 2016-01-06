class Api::V1::Customers::InvoicesController < Api::V1::InvoicesController
  respond_to :json

  def index
    respond_with Customer.get_invoices_for_a_given_customer(params[:id])
  end
end
