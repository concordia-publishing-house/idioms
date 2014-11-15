require "idioms/version"
require "idioms/http/errors"
require "idioms/rack/catch_invalid_params"
require "idioms/core_ext/array"
require "idioms/faraday/raise_errors" if defined?(Faraday)
