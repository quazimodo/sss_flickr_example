require "rexml/document"

module FlickrSss

  class PhotoAlbum

    attr_accessor :response_body, :xml, :photos

    def initialize(body)
      @response_body = body
      @xml = REXML::Document.new body
      build_photos
      build_urls
    end

    # I could use metaprogramming here, but given the very few methods, this is
    # simpler to understand

    def page; xml.elements["rsp/photos"].attributes["page"]; end

    def pages; xml.elements["rsp/photos"].attributes["pages"]; end

    def perpage; xml.elements["rsp/photos"].attributes["perpage"]; end

    def total; xml.elements["rsp/photos"].attributes["total"]; end

    private

    def build_photos
      @photos = xml.elements["rsp/photos"].elements.map do |photo|
        photo.attributes
      end
    end

    def build_urls

      photos.each do |photo|
        ["s", "q", "t", "m", "n", "-", "z", "c", "b", "h", "k", "o"].each do |x|

          url = "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_#{x}.jpg"
          photo << REXML::Attribute.new("url_#{x}", url)

        end
      end
    end
  end
end
