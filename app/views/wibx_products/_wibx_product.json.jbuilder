json.extract! wibx_product, :id, :title, :facebook_link, :whatsapp_link, :telegram_link, :facebook_gain, :whatsapp_gain, :telegram_gain, :facebook_requests, :whatsapp_requests, :telegram_requests, :total_user_product_gain, :user_facebook_gain, :user_whatsapp_gain, :user_telegram_gain, :status, :created_at, :updated_at
json.url wibx_product_url(wibx_product, format: :json)
