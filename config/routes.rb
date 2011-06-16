Likesdiary::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	
	devise_scope :user do
		get "/login" => "devise/sessions#new"
		get "/logout" => "devise/sessions#destroy"
		get "/register" => "devise/registrations#new"
	end

  resources :deals do
		resources :dealcomments
	end
	resources :maingroups
	resources :categories
	resources :subgroups
	resources :ratingcategories
	resources :products do
		resources :associations
		resources :productcomments, :except => [:index, :show]
		resources :reviews, :except => [:index, :show]
		member do
			get :users
			get :productcomments
			get :reviews
		end
	end

#get rid of except show above
	resources :users do
		member do
			get :following, :followers
		end
	end
  resources :user_sessions
	resources :cities
	resources :merchants do
		resources :merchantcomments
	end
	
	resources :relationships, :only => [:create, :destroy]
	resources :ratings, :only => [:create, :update]
	resources :product_likes, :only => [:create, :destroy]
	resources :merchant_likes, :only => [:create, :destroy]
	resources :deal_likes, :only => [:create, :destroy]

  get "user_sessions/new"

  get "users/new"
  
  match '/verify_user', :to => 'pages#verify_user'
  match '/logUser' , :to => 'pages#logUser'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match 'signup', :to => 'users#new'  
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
	match 'cheapsdiary' => 'deals#currentdeal'
	match 'search' => 'pages#search'
	match 'newsfeed', :to => 'users#newsfeed'	
	
  root :to => 'pages#home'

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