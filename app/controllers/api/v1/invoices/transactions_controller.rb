class Api::V1::Invoices::TransactionsController < Api::V1::TransactionsController
  respond_to :json

  def index
    respond_with Transaction.where("invoice_id = ?", params[:invoice_id])
  end

end
