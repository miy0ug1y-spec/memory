Rails.application.routes.draw do
  get "group_messages/create"
  get "group_messages/destroy"
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
  resources :endings, only:[:new, :create, :show, :edit, :update, :destroy] do
    member do
      get :download
    end
  end

  resources :relationships, only:[:create, :destroy]

	get 'mypost' => "posts#mypost"	
  get "mypage" =>"users#mypage"
  get "search" => "searches#index", as: :search

  resources :groups do
    resource :group_membership, only: [:create, :destroy], controller: "group_memberships"
    resources :group_memberships, only: [] do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :group_messages, only: [:create, :destroy]
  end
  

  namespace :admin do
    resources :users, only: [:index, :show] do
      member do
        patch :withdraw
        patch :activate
      end
    end
    resources :groups, only: [:index, :show, :destroy]
    resources :posts, only: [:destroy, :show, :index]
    resources :comments,only: [:destroy, :index]
    resources :endings, only: [:show]
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
