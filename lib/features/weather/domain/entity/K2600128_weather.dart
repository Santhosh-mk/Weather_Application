class K2600128_Weather {
  final String city;
  final double temp;

  final int? humidity;
  final double? windSpeed;
  final String? sunrise;
  final String? sunset;
  final List<DailyWeather>? daily; 

  K2600128_Weather({
    required this.city,
    required this.temp,
    this.humidity,
    this.windSpeed,
    this.sunrise,
    this.sunset,
    this.daily,
  });
}

class DailyWeather {
  final String day;
  final double temp;
  final int humidity;

  DailyWeather({
    required this.day,
    required this.temp,
    required this.humidity,
  });
}