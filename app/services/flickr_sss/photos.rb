module FlickrSss
  class Photos < Base

    def initialize(flickr)
      @flickr = flickr
      @photos = self
    end

    def search(search_string, options = {}, page = nil, per_page = nil)
      options.merge! text: search_string
      options.merge!(page: page) unless page.blank?
      options.merge!(per_page: per_page) unless per_page.blank?

      response = flickr.send_request 'flickr.photos.search', options
      FlickrSss::PhotoAlbum.new response.body
    end

  end
end
