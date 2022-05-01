# frozen_string_literal:true

Rails.application.routes.draw do
  resources :wibx_products
  resources :farm_links
  resources :face_accounts
  resources :wibx_accounts

  root 'application#home'
  get '/select_method', to: 'application#select_method'
  get '/wibx_farm', to: 'application#wibx_farm'
  get '/wibx_retriever', to: 'application#wibx_retriever'
  get '/remove_cloned', to: 'application#remove_cloned'
  get '/delete_links', to: 'application#delete_links'
  get '/create_products', to: 'application#create_products'
end
