Rails.application.routes.draw do
  resources :pages, :controller => 'high_voltage/pages', :only => :show
end
