
import '../../domain/entity/K2600128_weather.dart';
import '../../domain/repository/K2600128_weather_repository.dart';
import '../datasource/K2600128_openweather_api.dart';

class K2600128_WeatherRepositoryImpl implements K2600128_WeatherRepository {
  final K2600128_OpenweatherApi api;

  K2600128_WeatherRepositoryImpl(this.api);

  @override
  Future<K2600128_Weather> getWeather(String city) async {
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

      return K2600128_Weather(
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
