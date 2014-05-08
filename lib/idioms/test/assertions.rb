require "active_support/test_case"

module Idioms
  module Test
    module Assertions
      
      
      def refute_raises(exception)
        yield
      rescue exception
        flunk "#{$!.class} was raised\n#{$!.message}\n#{$!.backtrace.join("\n")}"
      end
      
      def assert_valid(record, message)
        assert record.valid?, message || "You expected #{record.class.name.downcase} to be valid, but it wasn't"
      end
      
      def refute_valid(record, message)
        refute record.valid?, message || "You expected #{record.class.name.downcase} to be **invalid**, but it wasn't"
      end
      
    end
  end
end

ActiveSupport::TestCase.send :include, Idioms::Test::Assertions
