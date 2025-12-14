import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/K2600128_weather_repository_impl.dart';
import '../../data/datasource/K2600128_openweather_api.dart';
import '../../domain/entity/K2600128_weather.dart';


final weatherRepositoryProvider = Provider<K2600128_WeatherRepositoryImpl>((ref) {
  return K2600128_WeatherRepositoryImpl(K2600128_OpenweatherApi() as K2600128_OpenweatherApi);
});

final weatherProvider = FutureProvider.family<K2600128_Weather, String>((ref, city) async {
  return ref.read(weatherRepositoryProvider).getWeather(city);
});
