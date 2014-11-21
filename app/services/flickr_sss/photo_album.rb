require "rexml/document"

module FlickrSss

  class PhotoAlbum

    attr_accessor :response_body, :xml, :photos

    def initialize(body, opts = {})
      @response_body = body
      @xml = REXML::Document.new body
      verify_xml
      build_photos
      build_urls unless opts[:build_urls].blank?
      build_largest_photo_url
    end

    # I could use metaprogramming here, but given the very few methods, this is
    # simpler to understand

    def page; xml.elements["rsp/photos"].attributes["page"]; end

    def pages; xml.elements["rsp/photos"].attributes["pages"]; end

    def perpage; xml.elements["rsp/photos"].attributes["perpage"]; end

    def total; xml.elements["rsp/photos"].attributes["total"]; end

    private

    def verify_xml
      raise MalformedXMLException if xml.elements["rsp/photos"].blank?
    end

    def build_photos
      @photos = xml.elements["rsp/photos"].elements.map do |photo|
        photo.attributes
      end
    end

    def build_largest_photo_url

      photos.each do |photo|

        ["o", "k", "h", "b", "c", "z", "-", "n", "m", "t", "q", "s"].each do |x|

          if photo.has_key? "url_#{x}"
            photo << REXML::Attribute.new("url_large", photo["url_#{x}"])
            break
          end

        end

      end

    end

    def build_urls
      photos.each do |photo|
        ["s", "q", "t", "m", "n", "-", "z", "c", "b", "h", "k", "o"].each do |x|

          case x
          when "o"
            unless photo['originalsecret'].blank?
              url = "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['originalsecret']}_#{x}.#{photo['originalformat']}"
              photo << REXML::Attribute.new("url_#{x}", url)
            end
          else
            url = "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_#{x}.jpg"
            photo << REXML::Attribute.new("url_#{x}", url)
          end
        end
      end
    end
  end
end
