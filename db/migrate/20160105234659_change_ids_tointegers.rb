class ChangeIdsTointegers < ActiveRecord::Migration
  def self.up
    change_column :invoice_items, :item_id, 'integer USING CAST(item_id AS integer)'
    change_column :invoice_items, :invoice_id, 'integer USING CAST(invoice_id AS integer)'
    change_column :invoices, :customer_id, 'integer USING CAST(customer_id AS integer)'
    change_column :invoices, :merchant_id, 'integer USING CAST(merchant_id AS integer)'
    change_column :items, :merchant_id, 'integer USING CAST(merchant_id AS integer)'
    change_column :transactions, :invoice_id, 'integer USING CAST(invoice_id AS integer)'
  end

  def self.down
    change_column :invoice_items, :item_id, :string
    change_column :invoice_items, :invoice_id, :string
    change_column :invoices, :customer_id, :string
    change_column :invoices, :merchant_id, :string
    change_column :items, :merchant_id, :string
    change_column :transactions, :invoice_id, :string
  end
end
