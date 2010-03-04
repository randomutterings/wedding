ActionController::Routing::Routes.draw do |map|
  map.resources :guests, :as => 'rsvps'

  map.resources :events

  map.resources :gifts

  map.resources :members, :as => 'party'

  
end
