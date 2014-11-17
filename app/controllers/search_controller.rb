class SearchController < ApplicationController

  # GET /search/q=search_terms
  def show
    @q = params[:q]

    if @q.empty?
       redirect_to root_path and return
    end

    flickr = FlickrSss.new key: ENV['FLICKR_API_KEY'], secret: ENV['FLICKR_API_SECRET']
    photos = flickr.photos
    @photo_album = photos.search "#{@q}"
  end

  # GET /search/new
  def new
  end

end
