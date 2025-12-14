import 'package:weather_application/features/weather/data/datasource/K2600128_openweather_api.dart';
import '../entity/K2600128_weather.dart';

class K2600128_WeatherRepository {
  final K2600128_OpenweatherApi api;
  K2600128_WeatherRepository(this.api);

  Future<K2600128_Weather> getWeather(String city) async {
    // Fetch current weather
    final data = await api.fetchCurrentWeather(city);

    // Fetch 7-day forecast
    final dailyData = await api.fetch5DayForecast(city); // List<Map>

    final dailyList = dailyData.map((d) => DailyWeather(
      day: d['day'],
      temp: d['temp'].toDouble(),
      humidity: d['humidity'],
    )).toList();

    return K2600128_Weather(
      city: city,
      temp: data['temp'].toDouble(),
      humidity: data['humidity'],
      windSpeed: data['wind_speed'].toDouble(),
      sunrise: data['sunrise'],
      sunset: data['sunset'],
      daily: dailyList,
    );
  }
}