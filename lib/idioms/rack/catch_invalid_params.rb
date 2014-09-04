module Rack
  class CatchInvalidParams

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue *parse_errors => error
      invalid_params!(env, error)
    end

    def invalid_params!(env, error)
      raise error unless env["CONTENT_TYPE"] =~ /application\/json/
      [
        400,
        { "Content-Type" => "application/json" },
        [{ status: 400, error: "There was a problem in the JSON you submitted: #{error}" }.to_json]
      ]
    end

    def parse_errors
      exceptions = []
      exceptions.push(MultiJson::LoadError) if _defined? "MultiJson::LoadError"
      exceptions.push(MultiJson::ParseError) if _defined? "MultiJson::ParseError"
      exceptions.push(ActionDispatch::ParamsParser::ParseError) if _defined? "ActionDispatch::ParamsParser::ParseError"
      exceptions
    end

    def _defined?(string)
      scope = Object
      string.split("::").each do |constant|
        return false if !scope.constants.member?(constant.to_sym)
        scope = scope.const_get(constant)
      end
      true
    end

  end
end
