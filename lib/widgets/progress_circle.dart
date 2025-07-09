import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: 260,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 12,
        backgroundColor: Colors.white10,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
      ),
    );
  }
}
