require 'json'

module Gapi
  class Result

    attr_reader :code
    attr_reader :errors


    attr_reader :json

    def initialize code, body, headers
      @code = code
      @errors = []
      process_result body, headers
    end


    # Is the request ok?
    def has_errors?
      @errors.size > 0
    end


    private

    def process_result body, headers
      @json = JSON.parse body
      #p @code, @json
      if @code != '200'
        if @json['errors']
          @errors = @json['errors']
        else
          @errors = ['<ERROR>']
        end
        return
      end
      process_collection_results
    end


    def process_collection_results
      # If there is no count then this isnt a collection
      return unless @json['count']
      @per_page = @json['max_per_page']
      @count = @json['count']
      @current_page = @json['current_page']
    end

  end
end
