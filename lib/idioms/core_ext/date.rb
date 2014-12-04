require "date"

module Idioms
  class InvalidDate < ArgumentError; end
  class InvalidDateTime < ArgumentError; end
end

class Date
  module ParseWithError

    def parse!(*args)
      time = parse(*args)
      if time && time.year > 294276
        raise Idioms::InvalidDate, "Years larger than 294276 are not supported by Postgres timestamps"
      end
      time
    rescue ArgumentError
      raise Idioms::InvalidDate, $!.message
    end

  end

  extend ParseWithError
end

class DateTime
  module ParseWithError

    def parse!(*args)
      time = parse(*args)
      if time && time.year > 294276
        raise Idioms::InvalidDate, "Years larger than 294276 are not supported by Postgres timestamps"
      end
      time
    rescue ArgumentError
      raise Idioms::InvalidDateTime, $!.message
    end

  end

  extend ParseWithError
end
