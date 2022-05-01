class AddFailToFarmLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :farm_links, :fail, :boolean
  end
end
