class WeatherPresenter
  def description
    weather_data['current']['condition']['text']
  end

  def temperature
    weather_data['current']['temp_c']
  end

  def icon
    weather_data['current']['condition']['icon']
  end

  def encourage_text
    if good_to_read_outside?
      'Get some snacks and go read a book in a park!'
    else
      'It is always a good weather to read a book!'
    end
  end

  private

  def weather_data
    @weather_data ||= WeatherApiConnector.new.weather_data

    # {
    #   'current' => {
    #     'condition' => {
    #       'text' => 'Sunny',
    #       'icon' => 'http://cdn.weatherapi.com/weather/64x64/day/113.png'
    #     },
    #     'temp_c' => 20
    #   }
    # }
  end

  def nice_weather?
    description == 'Sunny' || description == 'Partly cloudy'
  end

  def good_to_read_outside?
    nice_weather? && temperature > 15
  end
end
