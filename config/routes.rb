Rails.application.routes.draw do
  get 'cart/index'

  get 'cart/add'

  get 'cart/clear'

  resources :product_images

  resources :categories, :only => [:index,:new,:create,:destroy]
  resources :type_inventories, :only => [:index,:new,:create,:destroy]

  get "sign_up" => 'users#new', :as =>"sign_up"
  get "log_out" => 'sessions#destroy', :as =>"log_out"
  resources :fabrics, :only => [:index]
  resources :application, :only => [:index]
  resources :sessions
  resources :users do
    collection do
      get :login
    end
  end
  resources :customers
  
  resources :order_pos do
   collection do 
    put 'update_multiple_payment'
    end
  end

  resources :orders do
   collection do 
    put 'update_multiple_payment'
    end
  end
match "orders/:url_id" => "orders#show", :via=> [:get],:as => 'order_show'
match "order_pos/:url_id" => "order_pos#show", :via=> [:get],:as => 'order_po_show'
  #this resources will give CRUD function on inventories controller
  resources :inventories do
    #member to get the id
    member do
      delete 'remove_photo'
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'application#index'

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
