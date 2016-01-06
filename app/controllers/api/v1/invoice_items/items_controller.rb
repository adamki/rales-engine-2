class Api::V1::InvoiceItems::ItemsController < Api::V1::ItemsController
  respond_to :json

  def show
    respond_with Item.for_a_given_invoice_item(params[:id])
  end
end
