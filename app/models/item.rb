class Item < ActiveRecord::Base
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.invoices(id)
    joins(:invoices).where(invoices: { id: id })
  end

  def self.for_a_given_invoice_item(id)
    joins(:invoice_items).first
  end
end
