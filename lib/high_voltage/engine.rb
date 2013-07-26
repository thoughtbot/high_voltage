module HighVoltage
  class Engine < Rails::Engine
    initializer "Require concern path" do |app|
      concern_path = "app/controllers/concerns" 
      app.paths.add(concern_path) unless app.paths.keys.include?(concern_path)
      require "concerns/high_voltage/pageable.rb"
    end
  end
end


  
