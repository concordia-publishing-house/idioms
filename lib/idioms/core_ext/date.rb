require "date"

module Idioms
  class InvalidDate < ArgumentError; end
  class InvalidDateTime < ArgumentError; end
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

class DateTime
  module ParseWithError

    def parse!(*args)
      parse(*args)
    rescue ArgumentError
      raise Idioms::InvalidDateTime, $!.message
    end

  end

  extend ParseWithError
end
