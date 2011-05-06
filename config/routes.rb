Magfolio::Application.routes.draw do
  
  get "cartography" => "cartography#index", :as => "cartography"
  
  #get '/izbrannoes/getmy' => 'izbrannoes#getmy', :as => :getmy_izbrannoe
  resources :izbrannoes

  resources :business_deals

  resources :pictures

  match 'catalogs/:id/loadmap' => 'catalogs#loadmap', :as => :loadmap
  match 'catalogs/indexload' => 'catalogs#indexload', :as => :index_load
  resources :catalogs

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :users
  
  resources :sessions

  resources :locations

  match 'businesstype/getbusinesstypes' => 'business_types#getbusinesstypes'
  match 'businesstype/ajaxcreate' => 'business_types#ajaxcreate'
  resources :business_types

  match 'atlanta' => 'atlanta#index', :as => :atlanta
  get "atlanta/index"

  match 'success' => 'success#index', :as => :success
  
  match 'signup/getbusinessdeals' => 'signup#getbusinessdeals', :as => :getbusinessdeals
  match 'signup/setbusinessdeal' => 'signup#setbusinessdeal', :as => :setbusinessdeal
  match 'signup' => 'signup#stage1', :as => :signup
  match 'signup/stage1' => 'signup#stage1', :as => :signup_stage1
  match 'signup/stage2' => 'signup#stage2', :as => :signup_stage2
  match 'signup/stage3-free' => 'signup#stage3free', :as => :signup_stage3_free
  match 'signup/stage3-pay' => 'signup#stage3pay', :as => :signup_stage3_pay
  match 'signup/bestpictureupload' => 'signup#bestpictureupload', :as => :bestpictureupload
  match 'signup/:id/bestpictureurl' => 'signup#bestpictureurl', :as => :bestpictureurl
  match 'signup/:id/logoupload' => 'signup#logoupload', :as => :logoupload
  
  match 'about' => 'about#index', :as => :about

  match 'cities' => 'cities#index', :as => :cities
  match 'city/:city_name/service/:service_kind' => 'catalogs#index', :as => :search_city_name_service_kind
  match 'service/:service_kind' => 'catalogs#index', :as => :search_service_name
  match 'city/:city_name/product/:product_kind' => 'catalogs#index', :as => :search_city_name_product_kind
  match 'product/:product_kind' => 'catalogs#index', :as => :search_product_name
  match 'city/:city_name' => 'catalogs#index', :as => :search_city_name
  match '/:shortcut_name' => 'catalogs#show', :as => :shortcut_catalog
  root :to => "catalogs#index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
end
