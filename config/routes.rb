ActionController::Routing::Routes.draw do |map|
  map.resources :photos

  map.resources :sessions
  
  map.resources :pages

  map.resources :stories

  map.resources :articles

  map.resources :guests, :as => 'rsvp'

  map.resources :events

  map.resources :gifts, :as => 'gift_registry'

  map.resources :members, :as => 'party'

  map.root :controller => 'pages', :action => 'show', :permalink => 'home'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.page_permalink ':permalink', :controller => 'pages', :action => 'show'
end
