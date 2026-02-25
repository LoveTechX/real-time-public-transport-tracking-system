import 'package:flutter/material.dart';

import 'auth/driver_login.dart';
import 'auth/conductor_login.dart';
import 'passenger_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget roleCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      Widget screen,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),

        child: Row(
          children: [

            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Icon(icon,color: Colors.white,size: 30),
            ),

            const SizedBox(width: 20),

            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            const Icon(Icons.arrow_forward_ios)

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Smart Transport"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.directions_bus,
              size: 80,
              color: Colors.indigo,
            ),

            const SizedBox(height: 10),

            const Text(
              "Select Role",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            roleCard(
              context,
              "Passenger",
              Icons.person,
              Colors.green,
              const PassengerScreen(),
            ),

            roleCard(
              context,
              "Driver",
              Icons.drive_eta,
              Colors.blue,
              const DriverLoginScreen(),
            ),

            roleCard(
              context,
              "Conductor",
              Icons.confirmation_number,
              Colors.orange,
              const ConductorLoginScreen(),
            ),

          ],
        ),
      ),
    );
  }
}