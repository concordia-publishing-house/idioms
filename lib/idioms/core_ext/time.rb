require "time"

module Idioms
  class InvalidTime < ArgumentError; end
end

class Time
  module ParseWithError

    def parse!(*args)
      parse(*args)
    rescue ArgumentError
      raise Idioms::InvalidTime, $!.message
    end

  end

  extend ParseWithError
end
