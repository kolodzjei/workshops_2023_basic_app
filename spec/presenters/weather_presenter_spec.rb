require 'rails_helper'

RSpec.describe WeatherPresenter do
  let(:weather_data) do
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
  let(:weather_presenter) { described_class.new }

  before do
    allow_any_instance_of(WeatherApiConnector).to receive(:weather_data).and_return(weather_data)
  end

  describe '#description' do
    it 'returns weather description' do
      expect(weather_presenter.description).to eq('Sunny')
    end
  end

  describe '#temperature' do
    it 'returns weather temperature' do
      expect(weather_presenter.temperature).to eq(20)
    end
  end

  describe '#icon' do
    it 'returns weather icon' do
      expect(weather_presenter.icon).to eq('http://cdn.weatherapi.com/weather/64x64/day/113.png')
    end
  end

  describe '#location' do
    it 'returns weather location' do
      expect(weather_presenter.location).to eq('Cracow')
    end
  end

  describe '#encourage_text' do
    context 'when weather is nice and it is warm' do
      it 'returns a text encouraging to read outside' do
        expect(weather_presenter.encourage_text).to eq('Get some snacks and go read a book in a park!')
      end
    end

    context 'when weather is nice but it is cold' do
      it 'returns a text encouraging to read inside' do
        weather_data['current']['temp_c'] = 10
        expect(weather_presenter.encourage_text).to eq('It is always a good weather to read a book!')
      end
    end

    context 'when weather is not nice and it is warm' do
      it 'returns a text encouraging to read inside' do
        weather_data['current']['condition']['text'] = 'Rainy'
        expect(weather_presenter.encourage_text).to eq('It is always a good weather to read a book!')
      end
    end

    context 'when weather is not nice and it is cold' do
      it 'returns a text encouraging to read inside' do
        weather_data['current']['condition']['text'] = 'Rainy'
        weather_data['current']['temp_c'] = 10
        expect(weather_presenter.encourage_text).to eq('It is always a good weather to read a book!')
      end
    end
  end
end
