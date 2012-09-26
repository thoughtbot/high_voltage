Dummy::Application.routes.draw do
  match "/subclassed_pages/*id" => 'subclassed_pages#show', :format => false
  match "/alternative_finder/*id" => 'alternative_finder#show', :format => false
end
