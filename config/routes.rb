Dc3::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :oauth , :controller => 'oauth' do
    collection do
      get :start
      match :callback
      get :friends
    end
  end

  resources :upload , :controller => 'upload' do
    collection do
      get :index
      post :file
      get :complete
    end
  end

  get "sections/create"

  get "home/index"
  get "home/thanks"
  get "home/destroy"
  # get "home/reloadbattle"
  get "home/ajaxrandom"
  get "home/ajaxpopular"
  get "home/ajaxmyvideos"
  get "home/ajaxfreindvideos"
  get "home/section"
  get "home/createvideo"
  get "home/locale/:locale"   => "home#locale", :as => 'set_locale'

  match "/home/updatesession/:user_id"            => "home#updatesession", :as => 'updatesession'

  get "users/banned"

  get "webcam/new"
  match "webcam/submit"
  match "webcam/recorder/:track_id"               => 'webcam#recorder',    :as =>'webcam_recorder'
  match "webcam/nocamera"                         => 'webcam#nocamera',    :as =>'nocamera'
  match "webcam/deniedcamera"                     => 'webcam#deniedcamera',    :as =>'deniedcamera'
  
  match "/vid"              => "home#index", :as => 'random_video'
  match "/vid/:id"          => "home#index", :as => 'single_video'
  match "/vid/:ida/:idb"    => "home#index", :as => 'double_video'
  match "/mobile"           => 'home#mobile', :as => 'mobile'
  match "/home/reloadbattle(/:video_id)(/:autoplay)" => 'home#reloadbattle', :as => 'home/reloadbattle'

  match "/share/:id"      => "videos#share", :as => 'share_video'

  match "/info/rules"     => "home#rules", :as => 'rules'
  match "/info/faq"       => "home#faq", :as => 'faq'
  match "/info/terms"       => "home#terms", :as => 'terms'
  
  # match "/tab/xbox(/)"       => "tab#xbox", :as => 'tab_xbox'
  match "/tab/xbox(/:locale)"  => "tab#xbox", :as => 'tab_xbox'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :votes
  resources :tracks

  #resources :users
  match "/users/getUserinfo/:user_id"       => "users#getUserinfo", :as => 'getUserinfo'

  resources :videos

  match "/video/uploadform"       => "videos#uploadform", :as => 'uploadform'

  # match "/users/vote/:id" => "users#vote", :as => 'user_vote'
  match "/video/vote/:id" => "videos#vote", :as => 'video_vote'
  #match 'uvote/:id' => 'Users#vote', :as => 'user_vote'


  # root  :to => 'oauth#start'
  root  :to => 'home#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
