Rails.application.routes.draw do
  match '/pages/*id' => 'high_voltage/pages#show', :as => :page
end
