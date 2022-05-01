class CreateFarmLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :farm_links do |t|
      t.string :href

      t.timestamps
    end
  end
end
