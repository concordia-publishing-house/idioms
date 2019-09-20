$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "idioms"

require "minitest-reporters-turn_reporter"
MiniTest::Reporters.use! Minitest::Reporters::TurnReporter.new

require "shoulda/context"
require "timecop"
require "pry"
require "minitest/autorun"
