class Api::V1::InvoiceItems::InvoicesController < Api::V1::InvoicesController
  respond_to :json

  def show
    respond_with Invoice.for_a_given_invoice_item(params[:id])
  end
end
