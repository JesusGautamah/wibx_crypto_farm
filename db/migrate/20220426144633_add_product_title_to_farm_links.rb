class AddProductTitleToFarmLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :farm_links, :product_title, :string
  end
end
