puts "\e[33mDEPRECATED: Use the `minitest-reporters-turn_reporter` gem instead\e[0m"
require "minitest/reporters/turn_reporter"

module Idioms
  module Minitest
    Reporter = ::Minitest::Reporters::TurnReporter
  end
end
