import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favouritesProvider.dart';
import '../providers/weather_provider.dart';
import 'package:weather_icons/weather_icons.dart';

class favourites_screen extends ConsumerStatefulWidget {
  const favourites_screen({super.key});

  @override
  ConsumerState<favourites_screen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<favourites_screen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final favourites = ref.watch(favouritesProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add city bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        hintText: "Enter city name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final city = _cityController.text.trim();
                      if (city.isNotEmpty) {
                        ref.read(favouritesProvider.notifier).addFavourite(city);
                        _cityController.clear();
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // List of favourite cities
              Expanded(
                child: favourites.isEmpty
                    ? const Center(
                        child: Text(
                          "No favourite cities added",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favourites.length,
                        itemBuilder: (context, index) {
                          final city = favourites[index];
                          final weather = ref.watch(weatherProvider(city));

                          return Card(
                            color: Colors.white.withOpacity(0.2),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              onTap: () {
                                                  },
                              leading: const BoxedIcon(
                                WeatherIcons.day_sunny,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: Text(city, style: const TextStyle(color: Colors.white)),
                              subtitle: weather.when(
                                data: (w) => Text("${w.temp}°C", style: const TextStyle(color: Colors.white)),
                                loading: () => const Text("Loading...", style: TextStyle(color: Colors.white)),
                                error: (e, _) => const Text("Error fetching weather", style: TextStyle(color: Colors.white)),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white),
                                onPressed: () {
                                  ref.read(favouritesProvider.notifier).removeFavourite(city);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
