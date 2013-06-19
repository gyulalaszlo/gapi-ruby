module Gapi

  # A basic cache interface
  class Cache

    # Get an entry if its in the cache
    # or call block if not
    def get(key, &block); yield; end

    # Remove an entry from the cache
    def expire(key); end

    # Does the given key exist in the cache?
    def has?(key); end
  end


  # A simple implementation of the cache using
  # the file system
  class FileSystemCache < Cache

    attr_reader :dir

    def initialize( dir )
      @dir = dir
    end

    def has? key
      File.exist? get_path(key)
    end

    def get key, &block
      path = get_path(key)
      if File.exist? path
        return read_data(path)
      else
        result = yield
        write_data path, result
        return result
      end
    end


    # Expiring simply deletes the cache file
    def expire key
      path = get_path(key)
      if File.exist? path
        File.delete path
      end
    end

    private

    def read_data path
      JSON.parse File.read(path)
    end

    def write_data path, data_object
      File.open path, 'wb' do |f|
        f.write JSON.generate(data_object)
      end
    end

    def get_path(key)
      File.join @dir, "#{key}.tmp"
    end

  end
end
