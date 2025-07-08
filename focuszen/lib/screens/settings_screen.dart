import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int focusMinutes = 25;
  bool enableNotifications = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    focusMinutes = await StorageService.getFocusMinutes();
    enableNotifications = await StorageService.getNotificationSetting();
    setState(() {});
  }

  Future<void> updateDuration(int minutes) async {
    setState(() {
      focusMinutes = minutes;
    });
    await StorageService.setFocusMinutes(minutes);
  }

  Future<void> updateNotification(bool enabled) async {
    setState(() {
      enableNotifications = enabled;
    });
    await StorageService.setNotificationSetting(enabled);
  }

  void showDurationPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Select Focus Duration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [15, 20, 25, 30, 35, 40].map((minute) {
                  return ListTile(
                    title: Text("$minute minutes"),
                    onTap: () {
                      updateDuration(minute);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("Pomodoro Duration", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text("$focusMinutes minutes"),
              trailing: const Icon(Icons.chevron_right),
              onTap: showDurationPicker,
            ),
          ),
          const SizedBox(height: 30),
          SwitchListTile(
            value: enableNotifications,
            title: const Text("Enable Notifications"),
            onChanged: updateNotification,
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
