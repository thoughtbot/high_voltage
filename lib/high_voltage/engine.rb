module HighVoltage
  class Engine < Rails::Engine
    initializer 'Set up default parent engine' do |app|
      HighVoltage.parent_engine ||= Rails.application
    end

    initializer 'Require concerns path' do |app|
      concerns_path = 'app/controllers/concerns'

      unless app.paths.keys.include?(concerns_path)
        app.paths.add(concerns_path)
      end
    end
  end
end
