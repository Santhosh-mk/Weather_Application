import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Persistent favourites provider
final favouritesProvider = StateNotifierProvider<FavouritesNotifier, List<String>>((ref) {
  return FavouritesNotifier();
});

class FavouritesNotifier extends StateNotifier<List<String>> {
  FavouritesNotifier() : super([]) {
    loadFavourites(); // Load saved favourites on initialization
  }

  // Load favourites from shared preferences
  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favourites') ?? [];
    state = favList;
  }

  // Add a favourite city
  Future<void> addFavourite(String city) async {
    if (!state.contains(city)) {
      final updated = [...state, city];
      state = updated;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favourites', updated);
    }
  }

  // Remove a favourite city
  Future<void> removeFavourite(String city) async {
    final updated = state.where((c) => c != city).toList();
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favourites', updated);
  }

  // Clear all favourites
  Future<void> clearFavourites() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favourites');
  }
}
