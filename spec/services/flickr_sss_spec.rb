require 'spec_helper'

describe FlickrSss do

  describe "#new" do

    let(:opts) { { key: "some_key", secret: "some_secret" } }

    it "returns an object that allows us to query flickr" do

      flickr = FlickrSss.new opts
      expect(flickr).to be_an_instance_of FlickrSss::Base

    end

  end

end
