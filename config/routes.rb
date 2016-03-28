Rails.application.routes.draw do
  root 'startpage#show'
  
  resources :teams do
    resources :players, only: [:index]
    resources :events
    resources :practices
    resources :team_equipments, only: [:index]
    resources :game_jerseys, only: [:index, :create, :destroy]
    resources :game_pants, except: [:new, :show]
    member do
      get 'select'
      get 'depth-chart', to: 'teams#depth_chart'
    end
    post 'game_jerseys_upload', to: 'game_jerseys#upload'
  end

  resources :players do
    resources :contacts, only: [:create, :destroy]
    resources :rental_equipments, only: [:new, :create, :edit, :update, :destroy]
    resources :helmets, controller: 'rental_equipments', type: 'Helmet'
    resources :pads, controller: 'rental_equipments', type: 'Pad'
  end
  post 'players/upload', controller: 'players', action: 'upload'

  resources :sessions, only: [:create]
  get '/logout', to: 'sessions#clear'
  # Omniauth success callback
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:index, :edit, :update] do
    collection do
      get :guests
      get :managers
      get :all
    end    
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
