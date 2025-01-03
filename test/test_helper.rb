$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "idioms"

require "minitest/reporters/turn_reporter"
Minitest::Reporters.use! Minitest::Reporters::TurnReporter.new

require "shoulda/context"
require "timecop"
require "pry"
require "minitest/autorun"
