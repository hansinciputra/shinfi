Rails.application.routes.draw do
  resources :materials
  resources :craft_materials, :only => [:create]
  mount Ckeditor::Engine => '/ckeditor'
  resources :workshops do
    collection do
      get 'get_thumb_pic'
    end
  end

  resources :workshop_images do
    member do
      post 'set_dp'
    end
  end
  resources :crafts do
    collection do
      get 'craft_product'
      get 'user_craft_setup'
      get 'list_user_craft'
      post 'admin_new_craft'
      get 'new_custom_craft'
      post 'custom_craft_step1'
      post 'custom_craft_step3'
      get 'karya'
    end
    member do 
       
       get 'del_craft_material'
       get 'edit_custom_craft'
       put 'edit_custom_craft'
       post 'edit_step1_save'
       patch 'edit_step2_save'
       get 'edit_custom_craft_materials_step1'
       post 'edit_custom_craft_materials_step1'
       get 'edit_custom_craft_materials_step2'
       put 'edit_custom_craft_materials_step2'
    end
  end

  resources :compinfos 
  resources :prodtypes
  get 'cart/index'
  get 'cart/index_po'
  post'cart/addquantity'
  post'cart/addquantity_po'
  get 'cart/add'
  get 'cart/add_po_item'
  get 'cart/checkout_visitor'
  get 'cart/checkout_member'
  get 'cart/checkout_po_visitor'
  get 'cart/checkout_po_member'
  get 'cart/clear'
  get 'cart/clear_craft'
  get 'cart/clear_po'
  post 'cart/add_craft'
  resources :brands 
  resources :product_images do
    member do
      post 'set_display_picture_craft'
      post 'set_display_picture_inventory'
    end
  end
  resources :admin, :only => [:index]
  resources :report, :only => [:index]
  resources :main_posters
  resources :banners
  resources :sub_posters
  resources :prodtypes, :only => [:index,:new,:create,:destroy]
  resources :categories, :only => [:index,:new,:create,:edit,:destroy] do
    collection do 
      post 'sub_categories_create'
    end
    member do
      delete 'sub_categories_destroy'
    end
  end
  resources :type_inventories, :only => [:index,:new,:create,:destroy]

  get "sign_up" => 'users#new', :as =>"sign_up"
  get "log_out" => 'sessions#destroy', :as =>"log_out"
  resources :fabrics, :only => [:index] do
    member do
      get 'brand_caller'
    end
  end
  resources :supplies, :only => [:index] do
    member do
      get 'brand_caller'
    end
  end
  resources :application, :only => [:index]
  resources :sessions
  resources :users do
    collection do
      get :login
    end
    member do
      get 'user_detail'
      get 'change_password'
      patch 'change_password_commit'
      get 'order_history'
      get 'user_profile'
      get 'workshop'
      get 'e_stamp'
    end
  end
  resources :customers
  
  resources :order_pos do
   collection do 
    put 'update_multiple_payment'
    get 'po_shop'
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
    collection do
      post 'import'
      get 'import_product'
    end
  end
  
match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]
match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
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
