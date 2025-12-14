import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/K2600128_settings_provider.dart';
import '../providers/K2600128_favouritesProvider.dart';
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempUnit = ref.watch(tempUnitProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xff2193b0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Temperature Unit
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text("Temperature Unit"),
            subtitle: Text("Current: $tempUnit"),
            trailing: DropdownButton<String>(
              value: tempUnit,
              items: const [
                DropdownMenuItem(value: "°C", child: Text("Celsius (°C)")),
                DropdownMenuItem(value: "°F", child: Text("Fahrenheit (°F)")),
              ],
              onChanged: (value) {
                if (value != null) ref.read(tempUnitProvider.notifier).state = value;
              },
            ),
          ),

          const Divider(),

          // Theme Mode
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("App Theme"),
            subtitle: Text("Current: ${themeMode == ThemeMode.light ? "Light" : "Dark"}"),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (val) {
                ref.read(themeProvider.notifier).state =
                    val ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),

          const Divider(),

          // Clear Favourites
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text("Clear Favourites"),
            onTap: () {
              ref.read(favouritesProvider.notifier).clearFavourites(); // implement clear() in your favouritesProvider
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Favourites cleared!")),
              );
            },
          ),
        ],
      ),
    );
  }
}
