import 'dart:convert';
import 'package:http/http.dart' as http;

class openweather_api {
  final String apiKey = '75afb1ca5564156c5ded8b4819a742d9';

  // Fetch current weather
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'name': data['name'],
        'temp': data['main']['temp'],
        'humidity': data['main']['humidity'],
        'wind_speed': data['wind']['speed'],
        'sunrise': DateTime.fromMillisecondsSinceEpoch(
                data['sys']['sunrise'] * 1000)
            .toLocal()
            .toString()
            .split(' ')[1], // just HH:MM:SS
        'sunset': DateTime.fromMillisecondsSinceEpoch(
                data['sys']['sunset'] * 1000)
            .toLocal()
            .toString()
            .split(' ')[1],
      };
    } else {
      throw Exception('Failed to fetch current weather for $city');
    }
  }

  // Fetch 5-day forecast (one per day)
  Future<List<Map<String, dynamic>>> fetch5DayForecast(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['list'] as List;

      // Pick one forecast per day (every 8th entry ~ 24 hours)
      final daily = <Map<String, dynamic>>[];
      for (int i = 0; i < list.length; i += 8) {
        final item = list[i];
        daily.add({
          'day': DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000)
              .toLocal()
              .toString()
              .split(' ')[0],
          'temp': item['main']['temp'],
          'humidity': item['main']['humidity'],
        });
      }
      return daily;
    } else {
      throw Exception('Failed to fetch 5-day forecast for $city');
    }
  }
}
