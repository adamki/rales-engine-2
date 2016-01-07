class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.invoice(id)
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

  def revenue(date = nil)
    date.nil? ? revenue_for_merchant : revenue_for_merchant_by(date)
  end

  def self.total_revenue(date)
    select("merchants.*")
      .joins(invoices: :invoice_items)
      .merge(InvoiceItem.successful)
      .where(invoices: { created_at: date })
      .sum('quantity * unit_price').to_s
  end

  def self.most_items(qty)
    select("merchants.*, sum(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("item_count DESC")
      .merge(InvoiceItem.successful)
      .limit(qty)
    #    select / joins / group /  order / merge / limit
  end

  private

  def revenue_for_merchant
    invoices.success
      .joins(:invoice_items)
      .sum('quantity * unit_price').to_s
  end

  def revenue_for_merchant_by(date)
    invoices.success
      .where(invoices: { created_at: date })
      .joins(:invoice_items)
      .sum('quantity * unit_price').to_s
  end
end
