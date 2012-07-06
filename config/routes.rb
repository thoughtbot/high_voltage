Rails.application.routes.draw do
  unless HighVoltage.no_routes
    match "/#{HighVoltage.content_path}*id" => 'high_voltage/pages#show', :as => :page, :format => false
  end
end
