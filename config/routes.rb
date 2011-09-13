Rails.application.routes.draw do
  match '/pages/:action', :controller => 'high_voltage/pages', :as => :page, :format => false
end
