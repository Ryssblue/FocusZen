import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // ✅ Tambahkan ini
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // ✅ Ganti dengan ini
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusZen',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // ✅ Tambahan untuk device_preview
      builder: DevicePreview.appBuilder, // ✅ Tambahan untuk device_preview
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121629),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/stats': (context) => const StatsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
