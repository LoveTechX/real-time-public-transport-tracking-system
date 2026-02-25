import 'package:flutter/material.dart';

class PassengerLoginScreen extends StatelessWidget {
  const PassengerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger Login")),
      body: const Center(
        child: Text("Passenger Login Screen"),
      ),
    );
  }
}