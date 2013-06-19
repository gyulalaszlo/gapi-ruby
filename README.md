# G Adventures API bindings for Ruby

This is a simple client for the G Adventures web API. Currently only
supports reading operations.

## Basic requests

    request = Gapi::request.query('countries')
    result = request.run
    result.json['count'] # => 239

## Configuring

Set the API key using the config.

    request.config.application_key = API_KEY

Set the proxy:

    request.config.api_proxy = proxy_url
  

## Collections

Collections are simple wrappers around the resources to support loading
their index and loading individual elements.

    collection = Gapi::collection 'countries'
    collection.config.application_key = API_KEY

Fetch a country by id

    data = @collection.get 'GB'
    data['name'] # => 'United Kingdom'
    data['id']   # => 'GB'

Load the indices for all countries 

    collection.load_index
    collection.count      # => 239
    collection.per_page   # => 50
