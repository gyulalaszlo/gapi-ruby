require_relative '../../../gapi_keys'
require_relative '../../test_helper'
 
describe Gapi::Collection do
 
  it "should load a collection" do
    collection = Gapi::collection 'countries'
    collection.config.application_key = API_KEY
    collection.load_index.count.must_be :>, 100
    collection.indices[0]['href'].size.must_be :>, 10
  end

end
