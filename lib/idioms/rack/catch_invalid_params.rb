module Rack
  class CatchInvalidParams

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue MultiJson::LoadError => error
    rescue ActionDispatch::ParamsParser::ParseError => error
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

  end
end
