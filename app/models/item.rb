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

end
