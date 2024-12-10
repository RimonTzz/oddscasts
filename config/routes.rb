Rails.application.routes.draw do
  resources :contents
  namespace :admin do
    resources :articles
    resources :videos
  end
  resources :homes
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes (if needed)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Root path
  # root "posts#index"
end
