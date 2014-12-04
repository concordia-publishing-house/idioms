require "time"

module Idioms
  class InvalidTime < ArgumentError; end
end

class Time
  module ParseWithError

    def parse!(*args)
      time = parse(*args)
      if time && time.year > 294276
        raise Idioms::InvalidDate, "Years larger than 294276 are not supported by Postgres timestamps"
      end
      time
    rescue ArgumentError
      raise Idioms::InvalidTime, $!.message
    end

  end

  extend ParseWithError
end
