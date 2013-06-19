module Gapi
  class Request

    attr_reader :config

    # Create a new Request.
    # use Gapi::request() for creation
    def initialize( config )
      @config = config
    end


    def to_query_json
      validate!
      query = {
        'url' => "",
        'headers' => {},
        'body' => ''
      }
      add_headers_to query['headers']
      query
    end


    private


    def validate!
    end

    def query_url
    end


    def add_headers_to h
      h['X-Application-Key'] = config.application_key
      h['X-Api-Proxy'] = config.application_key if config.api_proxy
    end

  end
end
