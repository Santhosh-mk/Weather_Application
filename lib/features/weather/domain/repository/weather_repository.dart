import 'package:weather_application/features/weather/data/datasource/openweather_api.dart';
import '../../domain/entity/weather.dart';

class WeatherRepository {
  final openweather_api api;
  WeatherRepository(this.api);

  Future<Weather> getWeather(String city) async {
    // Fetch current weather
    final data = await api.fetchCurrentWeather(city);

    // Fetch 7-day forecast
    final dailyData = await api.fetch5DayForecast(city); // List<Map>

    final dailyList = dailyData.map((d) => DailyWeather(
      day: d['day'],
      temp: d['temp'].toDouble(),
      humidity: d['humidity'],
    )).toList();

    return Weather(
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