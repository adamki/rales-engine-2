class ChangeUnitPriceToFloatForItem < ActiveRecord::Migration
  def change 
    change_column :invoice_items, :unit_price, 'float USING CAST(unit_price AS float)'
    change_column :items, :unit_price, 'float USING CAST(unit_price AS float)'
  end
end
