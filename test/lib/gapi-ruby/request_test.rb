require_relative '../../../gapi_keys'
require_relative '../../test_helper'
 
describe Gapi::Request do
 
  it "It must use the correct API key" do
    request = Gapi::request
    request.config.application_key = '<LOREM IPSUM>'

    res = request.to_query_json
    res['headers']['X-Application-Key'].must_equal '<LOREM IPSUM>'
  end



  it "It must use the correct proxy" do
    request = Gapi::request
    request.to_query_json['headers']['X-Api-Proxy'].must_equal nil

    proxy_url = '192.168.1.101'
    request.config.api_proxy = proxy_url
    request.to_query_json['headers']['X-Api-Proxy'].must_equal proxy_url

  end

  it "It must use the correct collection and url" do
    request = Gapi::request
    request.query('countries').to_query_json['url'].must_equal "https://rest.gadventures.com/countries"
    request.query('tours').to_query_json['url'].must_equal "https://rest.gadventures.com/tours"
  end


  it 'must issue requests and parse the resulting JSON' do
    request = Gapi::request
    request.config.application_key = API_KEY
    request.query 'countries'
    result = request.run
    result.has_errors?.must_equal false
  end

end
