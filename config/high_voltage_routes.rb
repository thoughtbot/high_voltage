ActionController::Routing::Routes.draw do |map|
  map.resources :pages,
    :controller => 'high_voltage/pages',
    :only       => [:show]
end
