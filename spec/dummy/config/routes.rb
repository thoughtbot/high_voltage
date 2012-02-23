Dummy::Application.routes.draw do
  match "/subclassed_pages/*id" => 'subclassed_pages#show', :format => false
end
