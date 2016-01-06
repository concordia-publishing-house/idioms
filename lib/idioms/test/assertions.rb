require "active_support/test_case"

module Idioms
  module Test
    module Assertions


      def refute_raises(exception)
        yield
      rescue exception
        flunk "#{$!.class} was raised\n#{$!.message}\n#{$!.backtrace.join("\n")}"
      end

      def assert_valid(record)
        assert record.valid?, "Expected #{record.class.name.downcase} to be valid, but\n" <<
          record.errors.full_messages.map { |message| " * #{message}" }.join("\n")
      end

      def refute_valid(record, message=nil)
        refute record.valid?, message || "Expected #{record.class.name.downcase} to be **invalid**, but it wasn't"
      end

    end
  end
end

ActiveSupport::TestCase.send :include, Idioms::Test::Assertions
