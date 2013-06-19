module Gapi

  class Config

    attr_accessor :api_root
    attr_accessor :api_proxy
    attr_accessor :application_key

    def initialize
      @api_root = 'https://rest.gadventures.com'
      @api_proxy = nil
      @application_key = ''
    end

  end
end
