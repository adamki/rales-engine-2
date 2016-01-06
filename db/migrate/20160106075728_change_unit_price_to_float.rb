class ChangeUnitPriceToFloat < ActiveRecord::Migration
  def change_table
    remove_column :items, :unit_price, :integer
    add_column :items, :unit_price, :float
  end
end
