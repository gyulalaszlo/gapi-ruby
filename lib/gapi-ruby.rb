require_relative "gapi-ruby/version"
require_relative "gapi-ruby/config"
require_relative "gapi-ruby/request"

module Gapi

  # The default config uses no proxy and
  # the default GAPI access url
  DEFAULT_CONFIG = Config.new


  # Set the authentication key
  def set_api_key( application_key )
    DEFAULT_CONFIG.application_key = gapi_key
  end

  # Create a new request 
  def request( config = nil )
    config = Config.new unless config
    req = Request.new config
  end

  module_function :request
end
