require_relative '../../test_helper'
 
describe Gapi do
 
  it "must be defined" do
    Gapi::VERSION.wont_be_nil
  end
 
end
