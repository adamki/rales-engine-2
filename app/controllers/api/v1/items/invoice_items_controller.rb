class Api::V1::Items::InvoiceItemsController < Api::V1::InvoiceItemsController
  respond_to :json

  def index
    respond_with InvoiceItem.get_all_invoice_items_for_given_item(params[:id])
  end
end
