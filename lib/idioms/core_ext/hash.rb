module Idioms
  module CoreExt
    module Hash

      def extract(*keys)
        keys.each_with_object({}) { |key, new_hash| new_hash[key] = delete(key) if has_key?(key) }
      end

      def camelize_keys
        dup.camelize_keys!
      end

      def camelize_keys!
        keys.each do |key|
          case key
          when String, Symbol
            self[_camelize(key)] = self.delete(key)
          else next
          end
        end
        self
      end

    private

      def _camelize(key)
        matcher = /[\W_]+/
        new_key = key.to_s.split(matcher).each_with_index.map { |match, i| i == 0 ? match : match.capitalize }.join
        key.is_a?(Symbol) ? new_key.to_sym : new_key
      end

    end
  end
end

Hash.send :include, Idioms::CoreExt::Hash
