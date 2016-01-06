class Api::V1::Invoices::ItemsController < Api::V1::ItemsController
  respond_to :json

  def index
    respond_with Item.invoices(params[:invoice_id])
  end

end

