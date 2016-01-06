class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  def self.item(id)
    joins(:items).where(invoices: {id: id})
  end
end
