require 'test_helper'

class WeathersControllerTest < ActionController::TestCase
  setup do
    @weather = weathers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weathers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather" do
    assert_difference('Weather.count') do
      post :create, weather: { dewpoint: @weather.dewpoint, gust_speed: @weather.gust_speed, indoor_humidity: @weather.indoor_humidity, indoor_temp: @weather.indoor_temp, outdoor_humidity: @weather.outdoor_humidity, outdoor_temp: @weather.outdoor_temp, relative_pressure: @weather.relative_pressure, relative_rain: @weather.relative_rain, time: @weather.time, total_rain: @weather.total_rain, wind_chill: @weather.wind_chill, wind_direction: @weather.wind_direction, wind_speed: @weather.wind_speed }
    end

    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should show weather" do
    get :show, id: @weather
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather
    assert_response :success
  end

  test "should update weather" do
    patch :update, id: @weather, weather: { dewpoint: @weather.dewpoint, gust_speed: @weather.gust_speed, indoor_humidity: @weather.indoor_humidity, indoor_temp: @weather.indoor_temp, outdoor_humidity: @weather.outdoor_humidity, outdoor_temp: @weather.outdoor_temp, relative_pressure: @weather.relative_pressure, relative_rain: @weather.relative_rain, time: @weather.time, total_rain: @weather.total_rain, wind_chill: @weather.wind_chill, wind_direction: @weather.wind_direction, wind_speed: @weather.wind_speed }
    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should destroy weather" do
    assert_difference('Weather.count', -1) do
      delete :destroy, id: @weather
    end

    assert_redirected_to weathers_path
  end
end
