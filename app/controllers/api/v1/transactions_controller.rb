class Api::V1::TransactionsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Transaction.all  
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def find
    respond_with Transaction.where(transaction_params).first
  end

  def find_all
    respond_with Transaction.where(transaction_params)
  end

  def random
    random_transaction_id = rand(Transaction.count)
    respond_with Transaction.find(random_transaction_id)
  end

  private

    def transaction_params
      params.permit(:id,
                    :created_at,
                    :updated_at,
                    :invoice_id,
                    :credit_card_number,
                    :credit_card_expiration_date,
                    :result)
    end
end
