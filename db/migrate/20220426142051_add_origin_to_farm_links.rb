class AddOriginToFarmLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :farm_links, :origin, :integer
  end
end
