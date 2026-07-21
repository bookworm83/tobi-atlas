class UnsplashClient
  def self.fetch_photo_url(photo_name)
    response = Faraday.get("https://api.unsplash.com/photos/random") do |req|
      req.params["query"] = photo_name
      req.params["orientation"] = "portrait"
      req.headers["Authorization"] = "Client-ID #{Rails.application.credentials.unsplash[:access_key]}"
    end
    return nil if response.status != 200
    data = JSON.parse(response.body)
    return data.dig("urls","regular")
  end
end

pull request la misto