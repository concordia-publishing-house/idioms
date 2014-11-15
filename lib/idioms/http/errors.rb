module Idioms
  module HTTP
    class Error < RuntimeError
      attr_reader :env
      
      def initialize(env, message=nil)
        @env = env
        super message || default_message(env)
      end
      
      def default_message(env)
        "#{status} from #{env[:url].host}#{env[:url].path}"
      end
      
      def status
        env[:status]
      end
    end
    
    class ClientError < Error; end
    class ServerError < Error; end
    class UnrecognizedResponse < Error; end
    
    CLIENT_ERRORS = {
      400 => :BadRequest,
      401 => :Unauthorized,
      403 => :Forbidden,
      406 => :NotAcceptable,
      410 => :Gone,
      422 => :UnprocessableEntity }.freeze
    
    SERVER_ERRORS = {
      500 => :ServerError,
      502 => :BadGateway,
      503 => :ServiceUnavailable,
      504 => :GatewayTimeout }.freeze
    
    ERRORS = CLIENT_ERRORS.merge(SERVER_ERRORS).freeze
    
    CLIENT_ERRORS.each do |code, error|
      const_set error, Class.new(Idioms::HTTP::ClientError)
    end
    
    SERVER_ERRORS.each do |code, error|
      const_set error, Class.new(Idioms::HTTP::ServerError)
    end
    
  end
end
