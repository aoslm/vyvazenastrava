Vyziva::Application.routes.draw do

#MENU
  resources :menus
  match "menus/:id" => "menus#dynamic_type",as: "dynamic_type", via: :get
  get 'add_food_to_menu' => 'foods#add_food_to_menu'
  match 'remove_food_from_menu/:food_id/:menu_id' => 'menus#remove_food_from_menu', as: "remove_food_from_menu",
        via: :delete
  match 'update_menu' => 'menus#update', as: 'update_menu', via: :post
  match 'add_menu/:id' => 'menus#add', as: 'add', via: :post


#AJAX
  post "dynamic_types/:id" => "foods#dynamic_types"

#STATIC
  root :to => 'static_pages#home'
  get "static_pages/home" , :as => :home
  get "static_pages/help" , :as => :help
  get "static_pages/about" , :as => :about
  get 'static_pages/news', :as => :news

#USER
  resources :users
  get '/profile', to: 'users#profile', as: :profile
  get '/edit', to: 'users#edit', as: :edit
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

#FOOD
  resources :foods do
    resources :recipes
    get :autocomplete_food_slovakname, :on => :collection
  end
  match 'food/get/:from/:to' => 'foods#get', as: :get_food, via: :get
  match "foods/preview", to: "foods#preview", via: :post
  match "foods/filter", to: "foods#filter", via: :post
  match 'foods/search' => 'foods#search',  via: :post

  match 'foods/id/:id' =>  'foods#details', :as => :details_food, via: :get
  match 'foods/:id' =>  'foods#destroy', :as => :destroy_food, via: :delete
  match 'update_types' => 'foods#update_types', :as => :update_types, via: :get


#RECIPES
  get '/myRecipes', to: 'recipes#myRecipes', as: :myRecipes
  get '/elements', to: 'foods#elements', as: :elements
  match '/statistics' => 'foods#statistic', as: :statistic, :via=>:get


  #match 'foods/new' => 'foods#new', :as => :new_food, via: :get
  #match 'foods/get' => 'foods#get', via: :get
  #match 'foods/:category' => 'foods#index', :as => :foods, via: :get
  #match 'foods' => 'foods#index', :as => :foods, via: :get
  #match 'foods' => 'foods#create', via: :post

  #match 'foods/:id/edit' => 'foods#edit', :as => :edit_food, :via => :get
  #  # match 'foods' => 'foods/index',as => :user_foods, via: :get
  # match 'users/:id/foods/new' => 'foods#new', :as => :new_user_food, via: :get
  # match 'users/:id/foods/new' => 'foods#create', :as => :create_user_food, via: :post
  # match 'users/:id/foods/:id/add' => 'user#addfood', :as => :add_food, via: :post
  # match 'users/:user_id/foods/:id' =>  'foods#delete', :as => :user_delete_food, :via => :delete
  # match 'foods' =>  'foods#all', :as => :all_foods, :via => :get


=begin
  do
    resources :foods
    resources :recipes
  end
=end
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
  #root :to => 'welcome#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
