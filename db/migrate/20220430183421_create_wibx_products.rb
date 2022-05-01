class CreateWibxProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :wibx_products do |t|
      t.string :title
      t.integer :facebook_link
      t.integer :whatsapp_link
      t.integer :telegram_link
      t.float :facebook_gain
      t.float :whatsapp_gain
      t.float :telegram_gain
      t.integer :facebook_requests
      t.integer :whatsapp_requests
      t.integer :telegram_requests
      t.float :total_user_product_gain
      t.float :user_facebook_gain
      t.float :user_whatsapp_gain
      t.float :user_telegram_gain
      t.integer :status

      t.timestamps
    end
  end
end
