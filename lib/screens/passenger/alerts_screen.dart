import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Alerts"),
      ),
      body: const Center(
        child: Text(
          "No alerts available",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}