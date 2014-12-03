class SearchController < ApplicationController

  # GET /search/q=search_terms
  def show
    @q = params[:q]

    if @q.empty?
       redirect_to root_path and return
    end

    flickr_photos = FlickrSss.new(key: ENV['FLICKR_API_KEY'], secret: ENV['FLICKR_API_SECRET']).photos
    @photo_album = flickr_photos.search "#{@q}", page: params[:page]
  end

  # GET /search/new
  def new
  end

end
