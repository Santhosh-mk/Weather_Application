import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../../data/datasource/openweather_api.dart';
import '../../domain/entity/weather.dart';


final weatherRepositoryProvider = Provider<WeatherRepositoryImpl>((ref) {
  return WeatherRepositoryImpl(openweather_api());
});

final weatherProvider = FutureProvider.family<Weather, String>((ref, city) async {
  return ref.read(weatherRepositoryProvider).getWeather(city);
});
