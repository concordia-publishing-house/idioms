require "active_support/test_case"

module Idioms
  module Test
    module Assertions
      
      
      def refute_raises(exception)
        yield
      rescue exception
        flunk "#{$!.class} was raised\n#{$!.message}\n#{$!.backtrace.join("\n")}"
      end
      
      
    end
  end
end

ActiveSupport::TestCase.send :include, Idioms::Test::Assertions
