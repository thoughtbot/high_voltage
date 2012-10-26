Rails.application.routes.draw do
  if HighVoltage.routes
    get HighVoltage.route_drawer.match_attributes
  end
end
