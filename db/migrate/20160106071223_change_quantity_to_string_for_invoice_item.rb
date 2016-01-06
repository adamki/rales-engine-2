class ChangeQuantityToStringForInvoiceItem < ActiveRecord::Migration
  def self.up
    change_column :invoice_items, :quantity, 'integer USING CAST(quantity AS integer)'
  end

  def self.down
    change_column :invoice_items, :quantity, :string
  end
end
