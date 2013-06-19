require 'net/http'
require 'uri'

module Gapi
  class Request

    # The list of valid collections
    VALID_COLLECTION_NAMES = %w(
      countries
      states
      nationalities
      languages
      tours
      tourdossiers
      departures
      accommodations
      transports
      activities
      singlesupplements
      promotions
    )

    # Access to the used configuration
    attr_reader :config



    # The page to retrieve
    attr_accessor :page

    # Create a new Request.
    # use Gapi::request() for creation
    def initialize( config )
      @config = config
    end


    # Set the resource being queried.
    #
    # This method returns this Request object
    # so further methods can be chained together.
    def query collection_name
      @collection = collection_name
      self
    end

    def id id
      @id = id
      self
    end

    def run
      request_data = to_query_json!
      url = URI.parse( request_data['url'] )
      result = nil
      puts url
      Net::HTTP.start(url.host, url.port, :use_ssl => true) do |http|
        resp = http.get(url.request_uri, request_data['headers'])
        response_code = resp.code
        result = Result.new resp.code, resp.body, resp.to_hash
      end
      result
    end


    # Helper method for testing
    def to_query_json
      to_query_json!
    end


    private

    def to_query_json!
      validate!
      q = {
        'url' => query_url,
        'headers' => {},
        'body' => ''
      }
      add_headers_to q['headers']
      q
    end


    def validate!
      if @collection
        validate "Unsupported collection", VALID_COLLECTION_NAMES.include?(@collection) 
      end
    end

    # validation helper method
    def validate message, result
      return if result
      raise ArgumentError.new message
    end

    def query_url
      url = "#{config.api_root}/#{@collection}"
      url = "#{url}/#{@id}" if @id
      url = "#{url}/?page=#{@page}" if @page
      url
    end


    def add_headers_to h
      h['X-Application-Key'] = config.application_key
      h['X-Api-Proxy'] = config.api_proxy if config.api_proxy
    end

  end
end
