module Idioms
  module CoreExt
    module Hash

      def extract(*keys)
        keys.each_with_object({}) { |key, new_hash| new_hash[key] = delete(key) if has_key?(key) }
      end

    end
  end
end

Hash.send :include, Idioms::CoreExt::Hash
