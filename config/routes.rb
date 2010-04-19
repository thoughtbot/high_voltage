Rails.application.routes.draw do |map|
  resources :pages, :controller => 'high_voltage/pages', :only => [:show]
end
