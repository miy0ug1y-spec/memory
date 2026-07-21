Rails.application.routes.draw do
  get "searches/index"
  
  get "genres/index"
  get "genres/edit"

  root to: "homes#top"
  get 'about' => "homes#about"
  resources :registrations
  resource :session
  resources :passwords, param: :token
  resources :posts do
    resources :comments, only:[:create, :destroy]
 	end
  resources :users, path: 'users',path_names: { new: 'sign_up' } do
    member do
      patch :withdraw
    end
  end
  resources :endings, only:[:new, :create, :show, :edit, :update, :destroy]

	get 'mypost' => "posts#mypost"	
  get "mypage" =>"users#mypage"
  get "search" => "searches#index", as: :search
  

  namespace :admin do
    resources :users, only: [:show] do
      member do
        patch :withdraw
        patch :activate
      end
    end
    resources :posts, only: [:destroy, :show]
    resources :comments,only: [:destroy]
    resources :genres
    resource :session, only: [:new, :create, :destroy]
    resource :dashboard, only: :show
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
