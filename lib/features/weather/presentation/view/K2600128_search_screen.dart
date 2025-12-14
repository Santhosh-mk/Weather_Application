import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/K2600128_weather_provider.dart';
import 'package:weather_icons/weather_icons.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? searchedCity;

  @override
  Widget build(BuildContext context) {
    final weather = searchedCity == null
        ? null
        : ref.watch(weatherProvider(searchedCity!));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Search Weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Search Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  enableInteractiveSelection: false, // removes selection circle
                  decoration: InputDecoration(
                    labelText: "Enter City Name",
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          searchedCity = _controller.text.trim();
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Search Result
              Expanded(
                child: weather == null
                    ? const Center(
                        child: Text(
                          "Search a city to view the weather",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : weather.when(
                        data: (w) => SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                w.city,
                                style: const TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),

                              const BoxedIcon(
                                WeatherIcons.day_sunny,
                                size: 80,
                                color: Colors.white,
                              ),

                              const SizedBox(height: 10),
                              Text(
                                "${w.temp}°C",
                                style: const TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),
                              // Optional extra info card
                              Card(
                                color: Colors.white.withOpacity(0.2),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.thermostat,
                                                  color: Colors.white),
                                              SizedBox(width: 10),
                                              Text("Temperature",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                          Text("${w.temp}°C",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.location_on,
                                                  color: Colors.white),
                                              SizedBox(width: 10),
                                              Text("City",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                          Text(w.city,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                        error: (e, _) => Center(
                          child: Text(
                            "Error: $e",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
