class Api::V1::Transactions::InvoicesController < Api::V1::TransactionsController
  respond_to :json

  def show
    respond_with Transaction.get_invoice_for_a_given_transaction(params[:id])
  end
end
