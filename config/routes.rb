ActionController::Routing::Routes.draw do |map|
  map.resources :pages

  map.resources :stories

  map.resources :articles

  map.resources :guests, :as => 'rsvp'

  map.resources :events

  map.resources :gifts

  map.resources :members, :as => 'party'

  map.page_permalink ':permalink', :controller => 'pages', :action => 'show'
  
  map.root :controller => 'pages', :action => 'show', :permalink => 'home'
end
