json.array!(@weathers) do |weather|
  json.extract! weather, :id, :time, :indoor_temp, :outdoor_temp, :dewpoint, :wind_speed, :relative_rain, :wind_direction, :indoor_humidity, :outdoor_humidity, :relative_pressure, :wind_chill, :gust_speed, :total_rain
  json.url weather_url(weather, format: :json)
end
