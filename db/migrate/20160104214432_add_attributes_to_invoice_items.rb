class AddAttributesToInvoiceItems < ActiveRecord::Migration
  def change
    add_column :invoice_items, :item_id, :string
    add_column :invoice_items, :invoice_id, :string
    add_column :invoice_items, :quantity, :string
    add_column :invoice_items, :unit_price, :string
  end
end
