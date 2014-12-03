module RequestHelpers

    def simple_stub_request(url, opts={})
      opts[:status] ||= 200
      opts[:body] ||= ""
      opts[:method] ||= :get

      stub_request(opts[:method], url).
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => opts[:status], :body => opts[:body], :headers => {})
    end

end
