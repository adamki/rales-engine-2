class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: { id: id }).first
  end

  def self.get_invoices_for_a_given_customer(customer_id)
    self.find(customer_id).invoices
  end

  def favorite_merchant
    merchants.select("merchants.*, count(invoices.merchant_id) AS invoice_count")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group("merchants.id")
    .order("invoice_count DESC").first
  end
end
