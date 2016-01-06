class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  before_create :curreny_conversion

  def curreny_conversion
    self.unit_price = (self.unit_price.to_f/100)
  end

  def self.item(id)
    joins(:items).where(invoices: {id: id})
  end

  def self.get_all_invoice_items_for_given_item(item_id)
    joins(:item).where(items: {id: item_id})
  end

end
