require "rake"
tasks_path = File.join(File.dirname(__FILE__), "../tasks")
Dir.entries(tasks_path).grep(/\.rake$/).each do |ext|
  load File.join(tasks_path, ext)
end
