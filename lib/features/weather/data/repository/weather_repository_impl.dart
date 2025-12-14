import '../../domain/entity/weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/openweather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final openweather_api api;

  WeatherRepositoryImpl(this.api);

  @override
  Future<Weather> getWeather(String city) async {
    try {
      // Fetch current weather
      final current = await api.fetchCurrentWeather(city);

      // Fetch 5-day forecast
      final dailyData = await api.fetch5DayForecast(city);

      // Map daily data to DailyWeather list
      final dailyList = dailyData.map((d) => DailyWeather(
            day: d['day'],
            temp: (d['temp'] as num).toDouble(),
            humidity: d['humidity'] as int,
          )).toList();

      return Weather(
        city: current['name'] ?? city,
        temp: (current['temp'] as num).toDouble(),
        humidity: current['humidity'] as int,
        windSpeed: (current['wind_speed'] as num).toDouble(),
        sunrise: current['sunrise'] ?? '',
        sunset: current['sunset'] ?? '',
        daily: dailyList,
      );
    } catch (e) {
      throw Exception('Failed to fetch weather for $city: $e');
    }
  }
}
