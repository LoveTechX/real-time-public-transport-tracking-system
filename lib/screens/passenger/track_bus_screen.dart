import 'package:flutter/material.dart';

class TrackBusScreen extends StatelessWidget {
  const TrackBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Bus")),
      body: const Center(
        child: Text("Bus Tracking Screen"),
      ),
    );
  }
}