require 'spec_helper'
require 'webmock/rspec'

describe FlickrSss::PhotoAlbum do

  let(:body) do
    "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n
<rsp stat=\"ok\">\n
  <photos page=\"3\" pages=\"750\" perpage=\"5\" total=\"3749\">\n\t
    <photo id=\"15722897172\" owner=\"127055744@N05\" secret=\"4cdf097efd\" server=\"5615\" farm=\"6\" title=\"pregnancy test\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15080330164\" owner=\"10630857@N04\" secret=\"1935a54750\" server=\"3944\" farm=\"4\" title=\"Sprowston FBU picket on Friday night in Norwich at the start of the latest strike\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15080276024\" owner=\"10630857@N04\" secret=\"5bfce11ebe\" server=\"5608\" farm=\"6\" title=\"Earlham FBU picket on Friday night in Norwich at the start of the latest strike\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"9414703379\" owner=\"44494372@N05\" secret=\"0fd95a7804\" server=\"5529\" farm=\"6\" title=\"14x14-Inch Trisonic Wind Tunnel\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
    <photo id=\"15459432537\" owner=\"125915374@N07\" secret=\"b719eef69e\" server=\"5610\" farm=\"6\" title=\"Liam's Imagination\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n
  </photos>\n
</rsp>\n"
  end

  subject(:album) { FlickrSss::PhotoAlbum.new body }

  it "parses the xml string to an XML object" do
    expect(album.xml).to be_an_instance_of REXML::Document
  end

  it "builds an array of hash tables, each representing a photo" do
    photo = album.photos[2]
    expect(photo["id"]).to eq "15080276024"
    expect(photo["title"]).to eq "Earlham FBU picket on Friday night in Norwich at the start of the latest strike"
  end

  it "builds the urls for each image" do
    photo = album.photos[2]

    ["s", "q", "t", "m", "n", "-", "z", "c", "b", "h", "k", "o"].each do |x|
      expect(photo["url_#{x}"]).not_to be_blank
    end
  end

  it "tells you the page number" do
    expect(album.page).to eq "3"
  end

  it "tells you the total number of pages" do
    expect(album.pages).to eq "750"
  end

  it "tells you the per page" do
    expect(album.perpage).to eq "5"
  end

  it "tells you the total" do
    expect(album.total).to eq "3749"
  end
end
