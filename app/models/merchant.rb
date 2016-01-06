class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: {id: id}).first
  end

  def self.get_merchant_for_a_given_item(item_id)
    joins(:items).where(items: {id: item_id}).first
  end

  def favorite_customer
    customers.select("customers.*, count(invoices.merchant_id) AS invoice_count")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group("customers.id")
    .order("invoice_count DESC").first
  end

  def customers_with_pending_invoices
    invoices.joins(:transactions)
    .merge(Transaction.unsuccessful)
    .map(&:customer).uniq
  end
end
