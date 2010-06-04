line = "HighVoltage::Routes.draw(map)"
path = "config/routes.rb"

puts "inserting #{line} into #{path}"

content = File.read(path).gsub(/^(class|module|.*Routes).*$/) {|match| "#{match}\n  #{line}" }
File.open(path, 'wb') { |file| file.write(content) }
