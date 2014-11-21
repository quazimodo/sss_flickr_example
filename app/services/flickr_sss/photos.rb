module FlickrSss
  class Photos < Base

    def initialize(flickr)
      @flickr = flickr
      @photos = self
    end

    def search(search_string, options = {}, page = nil, per_page = nil)
      extras = [options["extras"], "original_format",
                "url_sq", "url_t", "url_s", "url_q",
                "url_m", "url_n", "url_z", "url_c",
                "url_l", "url_o"].join(',')

      options.merge!(extras: extras)
      options.merge! text: search_string
      options.merge!(page: page) unless page.blank?
      options.merge!(per_page: per_page) unless per_page.blank?

      response = flickr.send_request 'flickr.photos.search', options

      unless response.kind_of? Net::HTTPSuccess
        raise 'error', response.message
      end

      FlickrSss::PhotoAlbum.new response.body
    end

  end
end
