class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.get_invoice_for_a_given_transaction(transaction_id)
    self.find(transaction_id).invoice
  end

  def self.get_transactions_for_a_given_customer(customer_id)
    joins(:invoice).where(invoices: {customer_id: customer_id})
  end


end
