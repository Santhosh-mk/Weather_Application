import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Temperature unit: °C / °F
final tempUnitProvider = StateProvider<String>((ref) => "°C");

// Theme: light / dark
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
