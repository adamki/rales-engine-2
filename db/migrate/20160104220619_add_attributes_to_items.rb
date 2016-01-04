class AddAttributesToItems < ActiveRecord::Migration
  def change
    add_column :items, :name, :string
    add_column :items, :description, :string
    add_column :items, :unit_price, :integer
    add_column :items, :merchant_id, :string
  end
end
