require 'spec_helper'
require 'webmock/rspec'

describe FlickrSss::Base do

  let(:opts) { { key: "some_key", secret: "some_secret" } }
  let(:flickr) { FlickrSss::Base.new opts }

  describe "#new" do

    it "should raise an exception if api key and secret aren't supplied" do
      expect{FlickrSss::Base.new({abc: "def"})}.to raise_error ArgumentError
    end

    it "initialises flickr with a hash" do
      expect(flickr.key).to eq "some_key"
      expect(flickr.secret).to eq "some_secret"
    end

  end

  describe "#send_request" do

    it "defaults to flickr's REST endpoint" do
      uri = URI.parse FlickrSss::REST_ENDPOINT + "?"

      # this is hackish and I don't like it
      # the test works - but it indirectly tests that the method and api_key are
      # transmitted - it's not the explicit expectation. I'd much rather
      # something like 'expect(Net::HTTP).to receive(:get).with(URI) but this
      # tests the URI instancens against each other, not their 'equivalence'
      # so we are stuck with it till I figure out something better.

      # I don't like these tests
      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?api_key=some_key&method=fake_method").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      flickr.send_request :fake_method
      expect(stub).to have_been_requested
    end

    it "accepts a specified endpoint" do
      stub = stub_request(:get, "http://MyEndPoint/?api_key=some_key&method=fake_method").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      flickr.send_request :fake_method, {}, :get, "http://MyEndPoint"
      expect(stub).to have_been_requested
    end

    it "defaults to GET action" do

      expect(Net::HTTP).to receive(:get)
      flickr.send_request :fake_method

    end

    it "allows us to specify POST action" do

      expect(Net::HTTP).to receive(:post_form)
      flickr.send_request  :fake_method, {}, :post

    end

    it "transmits the api_method and key with the passed options" do

      transmitted_opts = "api_key=some_key&method=fake_method&zooby=looby"
      uri = URI.parse(FlickrSss::REST_ENDPOINT + "?" + transmitted_opts)

      stub = stub_request(:get, "http://api.flickr.com:443/services/rest/?api_key=some_key&method=fake_method&zooby=looby").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      flickr.send_request :fake_method, { zooby: "looby" }
    end

  end

  describe "#photos" do

    it "returns a FlickrSss::Photos instance" do

      photos = flickr.photos
      expect(photos).to be_an_instance_of FlickrSss::Photos

    end

  end

end
