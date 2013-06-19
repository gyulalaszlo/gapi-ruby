module Gapi
  class Collection

    attr_reader :name

    attr_reader :config


    # The loaded indices
    # Only valid if load_index was issued
    attr_reader :indices

    # The number of entities in the collection.
    # Only valid if load_index was issued
    attr_reader :count

    def initialize name, config
      @name = name
      @config = config
      @count = 0
      @results = []
      @indices = []
      @elements = {}
    end


    # Load the index of all the elements in this collection
    def load_index
      get_all
      self
    end

    
    # Get a single element by id
    def get id
      get_single id
      @elements[id]
    end

    private


    def get_all
      get_page()
      if @count > @per_page
        last_page = (@count / @per_page.to_f).ceil
        for i in 2..last_page
          get_page i
        end
      end
      merge_results
    end


    def get_single id
      req = Request.new( config ).query(@name).id(id)
      result = req.run
      # Check the result
      if result.has_errors?
        raise AccessError.new("Cannot retrieve collection")
      end
      @elements[id] = result.json
    end


    def get_page( page=1 )
      req = Request.new( config )
      req.query @name
      req.page = page 
      result = req.run
      # Check the result
      if result.has_errors?
        raise AccessError.new("Cannot retrieve collection")
      end
      unless result.json['count']
        raise FormatError.new("Result doesnt semms to be a collection")
      end
      # Parse out the collection
      @count = result.json['count']
      @per_page = result.json['max_per_page']
      # store the result
      @results[page] = result.json['results']
    end


    # Flatten the list of results into the @elements
    # array
    def merge_results
      @indices = @results.flatten
      # remove the leading nil (because page_count starts from 1)
      @indices.shift
    end

  end
end

