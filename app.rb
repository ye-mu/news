require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 39.9
  long = 116.3

  units = "metric" # or metric, whatever you like
  key = "97bfb67612070b4635bed5b97926f71c" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"
  url_news = "https://newsapi.org/v2/top-headlines?country=us&apiKey=765f57f524f44175866b92679b12e4e1"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash
  @news = HTTParty.get(url_news).parsed_response.to_hash

  ### Get the news
  view "news"
end

