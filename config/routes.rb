Rails.application.routes.draw do
  root to: "startpage#index"

  get "/admin", to: "admin/workshops#index"
  get "/terms", to: "startpage#terms"

  get "/instagram", to: "startpage#instagram"

  resources :workshops, except: [:edit]
  resources :tags, only: [:index, :create, :destroy], controller: "instagram_tags"
  resources :feed_images, only: [:index, :destroy]
  match "/admin/*path" => "admin/workshops#index", via: [:get], constraints: { format: 'html' }

  match "images/create_host" => "images#create_for_host", via: [:post]
  match "images/create_workshop" => "images#create_for_workshop", via: [:post]
end
