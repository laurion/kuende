Kuende::Application.routes.draw do
  get "/signin", to: "sessions#new", as: "signin"
  get "/signup", to: "identities#new", as: "signup"
  
  match "/logout", via: [:get], to: "sessions#destroy", :as => "logout"

  match '/auth/:provider/callback', via: [:get, :post],  to: 'sessions#create'  
  match '/auth/failure', via: [:get, :post], to: 'sessions#failure'
  resources :identities

  root :to => 'users#lobby', :constraints => lambda {|req| !req.session[:user_id].blank? }  
  root :to => 'static#landing'
end
