module Idioms
  module CoreExt
    module Array

      def average(&block)
        sum(&block).to_f / length
      end
      alias :avg :average

    end
  end
end

Array.send :include, Idioms::CoreExt::Array
