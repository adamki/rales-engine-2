class ChangeFloatToDecimal < ActiveRecord::Migration
  def down 
    change_column :items, :unit_price, :integer
  end

  def up
    change_column :items, :unit_price, :decimal
  end
end
