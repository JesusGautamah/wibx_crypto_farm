class AddFarmedToFarmLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :farm_links, :farmed, :boolean
  end
end
