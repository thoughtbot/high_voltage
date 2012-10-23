Rails.application.routes.draw do
  if HighVoltage.routes
    match HighVoltage.route_drawer.match_attributes
  end
end
