
require_relative '../../../gapi_keys'
require_relative '../../test_helper'
 
describe Gapi::Cache do

  before :each do
    @request = Gapi::request.query('countries')
    @request.config.application_key = API_KEY
  end

  it 'should cache the reults' do
    cache = Gapi::FileSystemCache.new '/tmp/gapi-cache/'
    @request.config.cache = cache
    
    cache_key = @request.get_cache_key
    result = @request.run
    cache.has?( cache_key ).must_equal true

    request2 = Gapi::request.query('countries')
    request2.config.application_key = API_KEY

    request2.config.cache = cache
    result = request2.run
    result.json['count'].must_be :>, 10
  end


  it 'should expire the reults' do
    cache = Gapi::FileSystemCache.new '/tmp/gapi-cache/'
    @request.config.cache = cache

    cache_key = @request.get_cache_key
    result = @request.run
    cache.has?( cache_key ).must_equal true

    # Remove it from the cache and 
    cache.expire cache_key
    cache.has?( cache_key ).must_equal false
  end
end

