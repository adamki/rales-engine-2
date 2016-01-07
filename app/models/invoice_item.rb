class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  has_many :transactions, through: :invoice

  #scope :successful, -> { joins(:invoice).merge(Invoice.success) }
  scope :successful, -> { joins(:transactions).where("transactions.result" => "success") }

  before_save :curreny_conversion

  def curreny_conversion
    self.unit_price = (self.unit_price/100.00)
  end

  def self.item(id)
    joins(:items).where(invoices: {id: id})
  end

  def self.get_all_invoice_items_for_given_item(item_id)
    joins(:item).where(items: {id: item_id})
  end

end
