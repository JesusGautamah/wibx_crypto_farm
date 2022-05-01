json.extract! wibx_account, :id, :email, :password, :created_at, :updated_at
json.url wibx_account_url(wibx_account, format: :json)
