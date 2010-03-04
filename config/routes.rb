ActionController::Routing::Routes.draw do |map|
  map.resources :articles

  map.resources :guests, :as => 'rsvp'

  map.resources :events

  map.resources :gifts

  map.resources :members, :as => 'party'

  
end
