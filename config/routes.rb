Rails.application.routes.draw do
  match "/#{HighVoltage::content_path}*id" => 'pages#show', :as => :page, :format => false

end
