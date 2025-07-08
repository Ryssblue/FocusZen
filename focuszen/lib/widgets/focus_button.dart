import 'package:flutter/material.dart';

class FocusButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isRunning;

  const FocusButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
