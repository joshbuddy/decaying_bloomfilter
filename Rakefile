begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "decaying_bloomfilter"
    s.description = s.summary = "Time Decaying Bloom Filter - Much like a bloom-filter except keys inserted decay over-time."
    s.email = "joshbuddy@gmail.com"
    s.homepage = "http://github.com/joshbuddy/decaying_bloomfilter"
    s.authors = ["Joshua Hull"]
    s.files = FileList["[A-Z]*", "{lib,spec}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
