ActionController::Routing::Routes.draw do |map|
  map.resources :clients do |client|
    client.resources :source_codes
  end
  
  map.connect 'codecatalogs/index/:id', :controller => 'codecatalogs'
end