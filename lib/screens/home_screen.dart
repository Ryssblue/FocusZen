import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/pomodoro_timer.dart';
import '../widgets/focus_button.dart';
import '../utils/timer_utils.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  int remainingSeconds = 1500;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    loadCustomDuration();
  }

  Future<void> loadCustomDuration() async {
    int customMinutes = await StorageService.getFocusMinutes();
    setState(() {
      totalSeconds = customMinutes * 60;
      remainingSeconds = totalSeconds;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        stopTimer(reset: false);
        StorageService.incrementSessionCount();
      }
    });
    setState(() {
      isRunning = true;
    });
  }

  void stopTimer({bool reset = true}) {
    timer?.cancel();
    setState(() {
      isRunning = false;
      if (reset) remainingSeconds = totalSeconds;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (totalSeconds - remainingSeconds) / totalSeconds;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FocusZen",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings').then((_) => loadCustomDuration());
                    },
                  )
                ],
              ),
            ),

            // Timer Widget
            Expanded(
              child: Center(
                child: PomodoroTimer(
                  progress: progress,
                  time: formatTime(remainingSeconds),
                ),
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: FocusButton(
                label: isRunning ? "Pause" : "Start",
                isRunning: isRunning,
                onPressed: isRunning ? stopTimer : startTimer,
              ),
            ),

            // Bottom Nav
            BottomNavigationBar(
              backgroundColor: const Color(0xFF1A1E33),
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.white54,
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.pushNamed(context, '/stats');
                } else if (index == 2) {
                  Navigator.pushNamed(context, '/settings').then((_) => loadCustomDuration());
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.timer), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
