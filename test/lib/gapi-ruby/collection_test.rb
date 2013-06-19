require_relative '../../../gapi_keys'
require_relative '../../test_helper'
 
describe Gapi::Collection do

  before :each do
    @collection = Gapi::collection 'countries'
    @collection.config.application_key = API_KEY
  end
 
  it 'should load a single one by id' do
    data = @collection.get 'GB'
    data['name'].must_equal 'United Kingdom'
    data['id'].must_equal 'GB'
  end

  it "should load a collection" do
    @collection.load_index.count.must_be :>, 100
    @collection.indices[0]['href'].size.must_be :>, 10
  end

end
