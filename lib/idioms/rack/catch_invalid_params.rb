module Rack
  class CatchInvalidParams

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue *parse_errors => error
      invalid_params!(env, error)
    rescue EOFError
      invalid_multipart!(env, $!)
    rescue *invalid_hash_errors
      invalid_hash_params!(env, $!)
    rescue StandardError
      # Hash::DisallowedType doesn't exist in Rails 4
      raise $! unless $!.class.to_s == "Hash::DisallowedType"
      invalid_xml_request!(env, $!)
    end

    def invalid_params!(env, error)
      raise error unless env["CONTENT_TYPE"] =~ /application\/json/
      [
        400,
        { "Content-Type" => "application/json" },
        [{ status: 400, error: "There was a problem in the JSON you submitted: #{error}" }.to_json]
      ]
    end
    
    def invalid_multipart!(env, error)
      raise error unless env["CONTENT_TYPE"] =~ /multipart\/form-data/ && env["REQUEST_METHOD"] == "GET"
      bad_request("400 Bad Request: Invalid multipart/form-data request")
    end
    
    def invalid_hash_params!(env, error)
      raise error unless error.to_s =~ /expected [\w:]+ \(.+\) for param/i
      bad_request
    end
    
    def invalid_xml_request!(env, error)
      raise error unless error.to_s =~ /Disallowed type attribute: "yaml"/
      bad_request
    end

    def parse_errors
      exceptions = []
      exceptions.push(MultiJson::LoadError) if _defined? "MultiJson::LoadError"
      exceptions.push(MultiJson::ParseError) if _defined? "MultiJson::ParseError"
      exceptions.push(ActionDispatch::ParamsParser::ParseError) if _defined? "ActionDispatch::ParamsParser::ParseError"
      exceptions
    end
    
    def invalid_hash_errors
      exceptions = [TypeError]
      exceptions << ActionController::BadRequest if defined?(ActionController::BadRequest)
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
    
    def bad_request(message="400 Bad Request")
      [400, {}, [message]]
    end

  end
end
