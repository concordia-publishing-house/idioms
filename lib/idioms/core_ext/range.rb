module Idioms
  module CoreExt
    module Range

      def in_batches_of(batch_size)
        _end = self.end
        Enumerator.new do |yielder|
          batch_begin = self.begin
          while true
            batch_end = batch_begin + batch_size
            if batch_end > _end
              break if batch_begin == _end && exclude_end?
              yielder << ::Range.new(batch_begin, _end, exclude_end?)
              break
            else
              yielder << ::Range.new(batch_begin, batch_end, true)
              batch_begin = batch_end
            end
          end
        end
      end

    end
  end
end

Range.send :include, Idioms::CoreExt::Range
