ActionController::Routing::Routes.draw do |map|
  map.resources :addresses
  map.resources :attendances
  map.resources :bands, :has_many => [ :performances, :songs, :tours ], :member => { :bandmates => :get }
  map.resources :bootlegs
  # map.resources :bootlegs, :member => { :owners => :get }
  map.resources :pages
  map.resources :password_resets
  map.resources :performances,  :has_many => [ :songs, :played_songs, :recordings, :attendances ], 
                                :member => { :songs => :get, :song_add => :post, :song_remove => :post, 
                                             :performers => :get, :performer_add => :post, :performer_remove => :post, 
                                             :setlist => :get }
  map.resources :performers, :member => { :bands => :get, :band_add => :post, :band_remove => :post }
  map.resources :played_songs
  map.resources :posts
  map.resources :recordings, :belongs_to => [ :performance, :taper ]
  map.resources :songs
  map.resources :tapers, :has_many => [:recordings]
  map.resources :tours, :has_many => :performances
  map.resources :user_sessions
  # map.resources :users, :member => {:bootlegs => :get, :bootleg_add => :post, :bootleg_remove => :post }
  map.resources :users, :has_many => [ :attendances, :bootlegs, :recordings ], 
                        :member => {:bootlegs => :get, :bootleg_add => :post, :bootleg_remove => :post,
                                    :add_attendance => :post, :remove_attendance => :post}
  map.resources :venues, :has_many => :performances
  
 
  map.with_options :controller => 'contact' do |contact|
    contact.contact '/contact',
      :action => 'index',
      :conditions => { :method => :get }
  
    contact.contact '/contact',
      :action => 'create',
      :conditions => { :method => :post }
  end
 
 
  
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.blog '/blog', :controller => 'posts'
  map.static ':permalink', :controller => 'pages', :action => 'show'
  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home", :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
