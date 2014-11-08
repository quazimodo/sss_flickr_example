module FlickrSss

  REST_ENDPOINT = "https://api.flickr.com/services/rest/"

  class Base

    attr_accessor :key, :secret, :endpoint

    def initialize(opts)
      self.key = opts[:key]
      self.secret = opts[:secret]
      self.endpoint = opts[:endpoint] || FlickrSss::REST_ENDPOINT
      validate!
    end

    def send_request(api_method, opts = {}, action = :get, endpoint = self.endpoint)

      opts.merge! method: api_method, api_key: key
      url = endpoint + "?" + opts.collect{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')

      case action
      when :get
        Net::HTTP.get URI.parse(url)
      when :post
        Net::HTTP.post_form URI.parse(endpoint)
      end
    end

    private

    def validate!
      raise ArgumentError, "flickr api key and secret must be supplied" unless (key && secret)
    end

  end
end
