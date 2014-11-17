require 'spec_helper'
require 'webmock/rspec'

describe FlickrSss::PhotoAlbum do

  let(:body) do
    "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<rsp stat=\"ok\">\n<photos page=\"1\" pages=\"786391\" perpage=\"5\" total=\"3931952\">\n\t
<photo id=\"15747759221\" owner=\"40201685@N00\" secret=\"439322c1b6\" server=\"7471\" farm=\"8\" title=\"20141107_M2_35-1.2_FP4_HC110B_18_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
<photo id=\"15749645845\" owner=\"40201685@N00\" secret=\"e2d9f9c74e\" server=\"3955\" farm=\"4\" title=\"20141107_M2_35-1.2_FP4_HC110B_35_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
<photo id=\"15563878849\" owner=\"127393233@N05\" secret=\"91374e0959\" server=\"8417\" farm=\"9\" title=\"TEST MARKER 2\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" originalsecret=\"2c38653b45\" originalformat=\"jpg\" />\n\t
<photo id=\"15130248943\" owner=\"40201685@N00\" secret=\"4035068210\" server=\"3937\" farm=\"4\" title=\"20141107_M2_35-1.2_FP4_HC110B_33_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n</photos>\n</rsp>\n"
  end

  subject(:album) { FlickrSss::PhotoAlbum.new body }

  it "raises an error if the document is missing required nodes" do
    body = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n
<rsp stat=\"ok\">\n
  <not_photos page=\"3\" pages=\"750\" perpage=\"5\" total=\"3749\">\n
  </not_photos>\n
</rsp>\n"

    expect{FlickrSss::PhotoAlbum.new body}.to raise_error
  end

  it "parses the xml string to an XML object" do
    expect(album.xml).to be_an_instance_of REXML::Document
  end

  it "builds an array of hash tables, each representing a photo" do
    photo = album.photos[2]
    expect(photo["id"]).to eq "15563878849"
    expect(photo["title"]).to eq "TEST MARKER 2"
  end

  it "builds the urls for each image" do
    photo = album.photos[2]

    ["s", "q", "t", "m", "n", "-", "z", "c", "b", "h", "k", "o"].each do |x|
      expect(photo["url_#{x}"]).not_to be_blank
    end
  end

  it "tells you the page number" do
    expect(album.page).to eq "1"
  end

  it "tells you the total number of pages" do
    expect(album.pages).to eq "786391"
  end

  it "tells you the per page" do
    expect(album.perpage).to eq "5"
  end

  it "tells you the total" do
    expect(album.total).to eq "3931952"
  end
end
