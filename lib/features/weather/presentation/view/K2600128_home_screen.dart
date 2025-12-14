import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_application/features/weather/presentation/view/K2600128_favourites_screen.dart';
import 'package:weather_application/features/weather/presentation/view/K2600128_settings_screen.dart';
import '../providers/K2600128_weather_provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'K2600128_search_screen.dart';
import 'K2600128_citydetails_screen.dart';

class K2600128_HomeScreen extends ConsumerStatefulWidget {
  const K2600128_HomeScreen({super.key});

  @override
  ConsumerState<K2600128_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<K2600128_HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const K2600128_SearchScreen(),       
    const K2600128_FavouritesScreen(),
    K2600128_CitydetailsScreen(city: "Colombo"),
    const K2600128_SettingsScreen()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2193b0),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "WEATHER APP",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: const Color.fromARGB(179, 0, 0, 0),
        backgroundColor: const Color.fromARGB(255, 10, 179, 222),

        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Details",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Details",
          ),
        ],
      ),
    );
  }
}


class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider("Colombo"));

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff2193b0),
            Color(0xff6dd5ed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: weather.when(
            data: (w) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // City
                Text(
                  w.city,
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Weather Icon
                const BoxedIcon(
                  WeatherIcons.cloud,
                  size: 80,
                  color: Colors.white,
                ),

                const SizedBox(height: 10),

                // Temperature
                Text(
                  "${w.temp}°C",
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // Card for Extra Info
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      infoRow(Icons.thermostat, "Temperature", "${w.temp}°C"),
                      const SizedBox(height: 8),
                      infoRow(Icons.location_on, "City", w.city),
                    ],
                  ),
                ),
              ],
            ),

            loading: () => const CircularProgressIndicator(color: Colors.white),

            error: (e, _) => Text(
              "Error: $e",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff2193b0),
            Color(0xff6dd5ed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
