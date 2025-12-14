import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/weather/presentation/providers/settings_provider.dart';
import 'features/weather/presentation/view/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyAppWrapper()));
}

// Wrapper to watch themeProvider
class MyAppWrapper extends ConsumerWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MyApp(themeMode: themeMode);
  }
}

// MyApp accepts the theme mode
class MyApp extends StatelessWidget {
  final ThemeMode themeMode;
  const MyApp({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
