Rails.application.routes.draw do
  match "/#{HighVoltage::content_path}*id" => 'high_voltage/pages#show', :as => :page, :format => false

end
