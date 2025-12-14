import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';
import '../../domain/entity/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class CityDetailsScreen extends ConsumerWidget {
  final String city;
  const CityDetailsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider(city));

    return Scaffold(
      appBar: AppBar(
        title: Text(city),
        backgroundColor: const Color(0xff2193b0),
      ),
      body: weatherAsync.when(
        data: (weather) => _buildWeatherContent(weather),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildWeatherContent(Weather weather) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Current Weather
          Card(
            color: Colors.blue.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(weather.city, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  BoxedIcon(WeatherIcons.cloud, size: 80),
                  const SizedBox(height: 10),
                  Text('${weather.temp}°C', style: const TextStyle(fontSize: 48)),
                  const SizedBox(height: 10),
                  Text('Humidity: ${weather.humidity}%', style: const TextStyle(fontSize: 18)),
                  Text('Wind: ${weather.windSpeed} km/h', style: const TextStyle(fontSize: 18)),
                  Text('Sunrise: ${weather.sunrise}', style: const TextStyle(fontSize: 16)),
                  Text('Sunset: ${weather.sunset}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 7-Day Forecast
          const Text(
            '7-Day Forecast',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...weather.daily!.map((day) => Card(
                child: ListTile(
                  leading: const BoxedIcon(WeatherIcons.day_sunny),
                  title: Text(day.day),
                  subtitle: Text('Temp: ${day.temp}°C, Humidity: ${day.humidity}%'),
                ),
              )),
        ],
      ),
    );
  }
}
