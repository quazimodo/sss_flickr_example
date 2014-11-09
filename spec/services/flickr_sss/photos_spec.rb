require 'spec_helper'
require 'webmock/rspec'

describe FlickrSss::Photos do

  let(:opts) { { key: "some_key", secret: "some_secret" } }

  let(:flickr) { FlickrSss::Base.new opts }

  let(:photos) { flickr.photos }

  it "initialises with original flickr object" do
    expect(photos.flickr).to eq flickr
  end

  # since this inherits from Base, it has #photos method. So this should
  # simply return self, not a new photos object
  it "doesn't nest Photos instances when calling #photos on self" do
    expect(photos.photos).to eq photos
  end

  describe "#search" do

    it "querys flickr's search resource" do
      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?api_key=some_key&method=flickr.photos.search&text=search%20string").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string"
      expect(stub).to have_been_requested

    end

    it "accepts a hash of options" do

      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }
      expect(stub).to have_been_requested

    end

    it "accepts optional page argument" do

      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&page=3&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }, 3
      expect(stub).to have_been_requested

    end

    it "accepts optional results per page argument" do

      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&per_page=5&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }, nil, 5
      expect(stub).to have_been_requested

    end

  end

end
