module Idioms
  class NullObjectClass

    def nil?
      true
    end

    def method_missing(*args, &block)
      self
    end

  end

  NullObject = NullObjectClass.new
end
