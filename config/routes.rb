Rails.application.routes.draw do
  root to: "startpage#index"

  get "/admin", to: "admin/workshops#index"

  resources :workshops, constraints: { format: 'json' }, except: [:edit, :show]
  match "/admin/*path" => "admin/workshops#index", via: [:get], constraints: { format: 'html' }
end
