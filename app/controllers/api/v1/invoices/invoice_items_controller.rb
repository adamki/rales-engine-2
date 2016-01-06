class Api::V1::Invoices::InvoiceItemsController < Api::V1::InvoiceItemsController
  respond_to :json

  def index
    respond_with InvoiceItem.where(invoice_id: params[:invoice_id])
  end
end
