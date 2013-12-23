module Server
  class << self

    def post(path, json)
      url = self.url(path)
      log("Making POST request to #{url}")
      RestClient.post(url, json, :content_type => :json, :accept => :json) do |res, req|
        res
      end
    end

    def delete(path)
      url = self.url(path)
      log("Making DELETE request to #{url}")
      RestClient.delete(url, :accept => :json) do |res, req|
        res
      end
    end

    def get(path)
      url = self.url(path)
      log("Making GET request to #{url}")
      RestClient.get(url, :accept => :json) do |res, req|
        res
      end
    end

    def url(path)
      base_url + path
    end

    def base_url
      ENV['YSLOW_DATA_SERVER_BASE_URL'] || 'http://localhost:3000'
    end

    def log(message)
      if(ENV['YSLOW_DATA_SERVER_LOG'] == 'true')
        puts message
      end
    end

  end
end