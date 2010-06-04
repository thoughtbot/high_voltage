line = "HighVoltage::Routes.draw(map)"
path = "config/routes.rb"

puts "inserting #{line} into #{path}"

content = File.read(path).gsub(/^(end\s*)$/) {|match| "  #{line}\n#{match}" }
File.open(path, 'wb') { |file| file.write(content) }
