class Item < ActiveRecord::Base
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  before_save :currency_conversion

  default_scope {order('ID ASC')}

  def currency_conversion
    self.unit_price = (self.unit_price/100.00)
  end

  def self.invoices(id)
    joins(:invoices).where(invoices: { id: id })
  end

  def self.for_a_given_invoice_item(invoice_item_id)
    joins(:invoice_items).where(invoice_items: { id: invoice_item_id }).first
  end

  def self.highest_ranked_merchant_by(qty)
    select("items.*, count(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .merge(InvoiceItem.successful)
      .uniq
      .group("items.id")
      .order("item_count DESC")
      .limit(qty)
  end

  def self.most_revenue(qty)
    select("items.*, count(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("items.id")
      .order("item_count DESC")
      .limit(qty)
  end

  def total_sold
    invoice_items.sum('quantity')
  end

end
