class Api::V1::Merchants::InvoicesController < Api::V1::InvoicesController
  respond_to :json

  def index
    respond_with Invoice.where(merchant_id: params[:merchant_id])
  end

end
