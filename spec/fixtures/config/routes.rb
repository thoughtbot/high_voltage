Dummy::Application.routes.draw do
  get "/subclassed_pages/*id" => 'subclassed_pages#show', :format => false
  get "/alternative_finder/*id" => 'alternative_finder#show', :format => false
end
