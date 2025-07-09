import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int focusSessions = 0;

  @override
  void initState() {
    super.initState();
    loadSessions();
  }

  Future<void> loadSessions() async {
    int count = await StorageService.getSessionCount();
    setState(() {
      focusSessions = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total Focus Sessions", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              "$focusSessions",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.bar_chart_rounded, size: 80, color: Colors.white30),
          ],
        ),
      ),
    );
  }
}
