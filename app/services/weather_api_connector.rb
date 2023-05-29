require 'uri'
require 'net/http'

class WeatherApiConnector
  API_KEY = A9n.weather_api_key

  def weather_data
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{location}&aqi=no"
    uri = URI(url)

    begin
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    rescue StandardError => e
      Rails.logger.error("Error while fetching weather data: #{e.message}")
      fallback_data
    end
  end

  private

  def location
    url = "https://api.ipgeolocation.io/ipgeo?apiKey=#{A9n.ip_geolocation_api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    city = JSON.parse(response)['city']
    city.parameterize || 'Cracow'
  end

  def fallback_data
    {
      'location' => {
        'name' => 'Cracow'
      },
      'current' => {
        'condition' => {
          'text' => 'Sunny',
          'icon' => 'http://cdn.weatherapi.com/weather/64x64/day/113.png'
        },
        'temp_c' => 20
      }
    }
  end
end
