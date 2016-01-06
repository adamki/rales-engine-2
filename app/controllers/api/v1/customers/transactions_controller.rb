class Api::V1::Customers::TransactionsController < Api::V1::TransactionsController
  respond_to :json

  def index
    respond_with Transaction.get_transactions_for_a_given_customer(params[:id])

  end

end
