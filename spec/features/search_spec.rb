require 'rails_helper'

describe "flickr image search" do
  let(:body) do
    "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<rsp stat=\"ok\">\n<photos page=\"1\" pages=\"786391\" perpage=\"5\" total=\"3931952\">\n\t
<photo id=\"15747759221\" owner=\"40201685@N00\" secret=\"439322c1b6\" server=\"7471\" farm=\"8\" title=\"20141107_M2_35-1.2_FP4_HC110B_18_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
<photo id=\"15749645845\" owner=\"40201685@N00\" secret=\"e2d9f9c74e\" server=\"3955\" farm=\"4\" title=\"20141107_M2_35-1.2_FP4_HC110B_35_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n\t
<photo id=\"15563878849\" owner=\"127393233@N05\" secret=\"91374e0959\" server=\"8417\" farm=\"9\" title=\"TEST MARKER 2\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" originalsecret=\"2c38653b45\" originalformat=\"jpg\" />\n\t
<photo id=\"15130248943\" owner=\"40201685@N00\" secret=\"4035068210\" server=\"3937\" farm=\"4\" title=\"20141107_M2_35-1.2_FP4_HC110B_33_web\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" />\n</photos>\n</rsp>\n"
  end

  it "new search is the root" do
    visit root_path

    expect(page).to have_button "image search"
  end

  it "returns a number of images as thumbnails with captions from flickr" do

    stub_request(:get, /https:\/\/api\.flickr\.com\/services\/rest\/\?api_key=.*?&method=flickr\.photos\.search&text=.*?\z/).
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => body, :headers => {})


    visit new_search_path
    fill_in 'q', with: "search term"

    click_button 'image search'

    # should see 5 hyperlinked images on the page
    expect(page).to have_xpath('//a/img', count: 4)
    # should have the correct image src for the 3rd image
    expect(page).to have_xpath("//a/img[@src='https://farm9.staticflickr.com/8417/15563878849_91374e0959_t.jpg']")
    # should link to the image original, if available] for the 3rd image
    expect(page).to have_xpath("//a[@href='https://farm9.staticflickr.com/8417/15563878849_2c38653b45_o.jpg']")

  end

end
