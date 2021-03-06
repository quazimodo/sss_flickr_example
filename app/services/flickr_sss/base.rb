require "net/http"

module FlickrSss

  REST_ENDPOINT = "https://api.flickr.com/services/rest/"

  class Base

    attr_accessor :key, :secret, :endpoint, :flickr

    def initialize(opts)
      @key = opts[:key]
      @secret = opts[:secret]
      @endpoint = opts[:endpoint] || FlickrSss::REST_ENDPOINT
      @flickr = self
      validate!
    end


    # Simple method for crafting requests to the flickr REST api via HTTP
    def send_request(api_method, opts = {}, action = :get, endpoint = self.endpoint)

      opts.merge! method: api_method, api_key: key

      case action
      when :get
        url_string = endpoint + "?" + opts.collect{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')
        url = URI.parse(url_string)
        req = Net::HTTP::Get.new url.request_uri

        Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
          http.request req
        end
      when :post
        Net::HTTP.post_form URI.parse(endpoint), opts
      end
    end

    def photos
      @photos ||= FlickrSss::Photos.new self
    end

    private

    def validate!
      raise ArgumentError, "flickr api key and secret must be supplied" unless (key && secret)
    end

  end


  class MalformedXMLException < Exception
  end
end
