module HighVoltage
  class Engine < Rails::Engine
    initializer 'Require concerns path' do |app|
      concerns_path = 'app/controllers/concerns'

      unless app.paths.keys.include?(concerns_path)
        app.paths.add(concerns_path)
      end

      require 'concerns/high_voltage/static_page'
    end
  end
end
