require_relative "gapi-ruby/version"
require_relative "gapi-ruby/config"
require_relative "gapi-ruby/request"

require_relative "gapi-ruby/cache"

require_relative "gapi-ruby/response"
require_relative "gapi-ruby/collection"




module Gapi

  class AccessError < StandardError
    def initialize *args
      super( *args )
    end
  end

  class FormatError < StandardError
    def initialize *args
      super( *args )
    end
  end

  # The default config uses no proxy and
  # the default GAPI access url
  DEFAULT_CONFIG = Config.new


  # Set the authentication key
  def set_api_key( application_key )
    DEFAULT_CONFIG.application_key = gapi_key
  end

  # Create a new request 
  def request( config = nil )
    req = Request.new Gapi::ensure_config(config)
  end


  # Create a new collection
  def collection name, config = nil
    Collection.new name, Gapi::ensure_config(config)
  end


  def ensure_config config
    config = Config.new unless config
    config
  end


  module_function :request
  module_function :collection

  module_function :ensure_config
end
