ActionController::Routing::Routes.draw do |map|
  map.resources :guests

  map.resources :events

  map.resources :gifts

  map.resources :members

  
end
