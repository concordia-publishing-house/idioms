require "date"

module Idioms
  class InvalidDate < ArgumentError; end
end

class Date
  module ParseWithError

    def parse!(*args)
      parse(*args)
    rescue ArgumentError
      raise Idioms::InvalidDate, $!.message
    end

  end

  extend ParseWithError
end
