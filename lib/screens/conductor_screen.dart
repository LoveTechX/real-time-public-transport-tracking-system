import 'package:flutter/material.dart';

class ConductorScreen extends StatelessWidget {
  const ConductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conductor Dashboard"),
      ),
      body: const Center(
        child: Text(
          "Conductor Dashboard",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}