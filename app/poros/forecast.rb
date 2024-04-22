class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = format_current_weather(data[:current])
    @daily_weather = format_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = format_hourly_weather(data[:forecast][:forecastday][0][:hour])
  end

  def format_current_weather(current_data)
    weather_now = {}
    weather_now[:last_updated] = current_data[:last_updated]
    weather_now[:temperature] = current_data[:temp_f]
    weather_now[:feels_like] = current_data[:feelslike_f]
    weather_now[:humidity] = current_data[:humidity]
    weather_now[:uvi] = current_data[:uv]
    weather_now[:visibility] = current_data[:vis_miles]
    weather_now[:condition] = current_data[:condition][:text]
    weather_now[:icon] = current_data[:condition][:icon]
    weather_now
  end

  def format_daily_weather(five_day_data)
    days_weather = []
    five_day_data.each do |one_day|
      daily = {}
      daily[:date] = one_day[:date]
      daily[:sunrise] = one_day[:astro][:sunrise]
      daily[:sunset] = one_day[:astro][:sunset]
      daily[:max_temp] = one_day[:day][:maxtemp_f]
      daily[:min_temp] = one_day[:day][:mintemp_f]
      daily[:condition] = one_day[:day][:condition][:text]
      daily[:icon] = one_day[:day][:condition][:icon]
      days_weather << daily
    end
    days_weather
  end

  def format_hourly_weather(hours_data)
    all_hours = []
    hours_data.each do |hour_data|
      hour = {}
      hour[:time] = Time.parse(hour_data[:time]).to_fs(:time)
      hour[:temperature] = hour_data[:temp_f]
      hour[:conditions] = hour_data[:condition][:text]
      hour[:icon] = hour_data[:condition][:icon]
      all_hours << hour
    end
    all_hours
  end
end