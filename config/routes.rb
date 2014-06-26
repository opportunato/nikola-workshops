Rails.application.routes.draw do
  root to: "startpage#index"

  get "/admin", to: "admin/workshops#index"

  resources :workshops, constraints: { format: 'json' }, except: [:edit, :show]
  match "/admin/*path" => "admin/workshops#index", via: [:get], constraints: { format: 'html' }

  match "images/create_host" => "images#create_for_host", via: [:post]
  match "images/create_workshop" => "images#create_for_workshop", via: [:post]
end
