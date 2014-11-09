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
      stub = stub_request(:get, "https://api.flickr.com:443/services/rest/?api_key=some_key&method=flickr.photos.search&text=search%20string").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string"
      expect(stub).to have_been_requested

    end

    it "accepts a hash of options" do

      stub = stub_request(:get, "https://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }
      expect(stub).to have_been_requested

    end

    it "accepts optional page argument" do

      stub = stub_request(:get, "https://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&page=3&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }, 3
      expect(stub).to have_been_requested

    end

    it "accepts optional results per page argument" do

      stub = stub_request(:get, "https://api.flickr.com:443/services/rest/?accuracy=1&api_key=some_key&method=flickr.photos.search&per_page=5&tags=foo,bar,zed&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      photos.search "search string", { tags: "foo,bar,zed", accuracy: 1 }, nil, 5
      expect(stub).to have_been_requested

    end

    it "returns a photo_album object if successful" do

      body = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n
<rsp stat=\"ok\">\n
  <photos page=\"1\" pages=\"750\" perpage=\"5\" total=\"3749\">\n\t
    <photo id=\"15722897172\" owner=\"127055744@N05\" secret=\"4cdf097efd\" server=\"5615\" farm=\"6\" title=\"pregnancy test\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15080330164\" owner=\"10630857@N04\" secret=\"1935a54750\" server=\"3944\" farm=\"4\" title=\"Sprowston FBU picket on Friday night in Norwich at the start of the latest strike\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15080276024\" owner=\"10630857@N04\" secret=\"5bfce11ebe\" server=\"5608\" farm=\"6\" title=\"Earlham FBU picket on Friday night in Norwich at the start of the latest strike\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"9414703379\" owner=\"44494372@N05\" secret=\"0fd95a7804\" server=\"5529\" farm=\"6\" title=\"14x14-Inch Trisonic Wind Tunnel\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15459432537\" owner=\"125915374@N07\" secret=\"b719eef69e\" server=\"5610\" farm=\"6\" title=\"Liam's Imagination\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n
  </photos>\n
</rsp>\n"

      stub = stub_request(:get, "https://api.flickr.com/services/rest/?api_key=some_key&method=flickr.photos.search&text=search%20string").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})

      response = photos.search "search string"
      expect(response).to be_an_instance_of FlickrSss::PhotoAlbum
    end

  end

end
