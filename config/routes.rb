HighVoltage.parent_engine.routes.draw do
  if HighVoltage.home_page
    get "/#{HighVoltage.home_page}", to: redirect('/')
    root to: 'high_voltage/pages#show', id: HighVoltage.home_page
  end

  if HighVoltage.routes
    get HighVoltage.route_drawer.match_attributes
  end
end
