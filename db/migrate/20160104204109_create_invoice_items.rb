class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|

      t.timestamps null: false
    end
  end
end
