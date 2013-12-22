MusicScraper::Application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :songs do

    collection do 
      get "source"
      get "search"
    end

    member do 
      #Gets the Actions in the Songs Controller
      get "starred"
      get "unstarred"
      get "starredhome"
      get "unstarredhome"
      get "unstarredatfaves"
      get "starredsource"
      get "unstarredsource"
      get "myfaves"
    end
  end


  # get '/songs/:id/:action' => 'songs#starred' 
  # get '/songs/:id/:action' => 'songs#unstarred'
  
  #Filter Songs By Blog
     #** WORKS
   #  get '/songs/source/www.inflexwetrust.com' => 'songs#source'
    #  Close

 # get 'songs_source', :controller => 'songs', :action => 'source'
  #get '/songs/source/:source' => 'songs#source' #, :as => source
 # get '/songs/source/', :controller => 'songs', :action => 'source'
  # get '/songs/source/rapradar', :controller => 'songs', :action => 'Song.source = "rapradar.com"'


  match 'users/sign_out', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  #get '/users/sign_out' => 'sessions#destroy', as: 'sign_out'

  # resources :songs do
  #   member do
  #     get "like", => "songs#starred"
  #     get "dislike", => "songs#unstarred"
  #   end
  # end

  get "pages/home"
  get "/about" => "songs#about"
  get "/myfaves" => 'songs#myfaves'


  get 'custom_login' => 'songs#index'
  # You can have the root of your site routed with "root"
  root 'songs#index'
  #get '/show' =>  'songs#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



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
