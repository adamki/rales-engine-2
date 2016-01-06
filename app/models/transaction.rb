class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.get_invoice_for_a_given_transaction(transaction_id)
    joins(:invoice).where(transactions: {id: transaction_id}).first
  end
end
