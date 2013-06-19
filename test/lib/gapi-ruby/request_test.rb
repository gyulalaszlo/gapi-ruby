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

end
