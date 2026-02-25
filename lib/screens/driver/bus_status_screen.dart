import 'package:flutter/material.dart';

class BusStatusScreen extends StatelessWidget {
  const BusStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Bus Status"),
      ),

      body: const Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.directions_bus,
              size: 80,
              color: Colors.indigo,
            ),

            SizedBox(height: 20),

            Text(
              "Bus Running Normally",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),

    );
  }
}