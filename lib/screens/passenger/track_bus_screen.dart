import 'package:flutter/material.dart';
import '../../../core/di/service_locator.dart';
import '../../../features/tracking/domain/bus_location.dart';

class TrackBusScreen extends StatelessWidget {
  const TrackBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded busId for now (we will improve later)
    const String busId = "bus_1";

    return Scaffold(
      appBar: AppBar(title: const Text("Track Bus")),
      body: StreamBuilder<BusLocation>(
        stream:
            ServiceLocator.trackingController.getBusLocation(busId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No Data Available"));
          }

          final busLocation = snapshot.data!;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Live Bus Location",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text("Latitude: ${busLocation.latitude}"),
                Text("Longitude: ${busLocation.longitude}"),
                const SizedBox(height: 10),
                Text("Last Updated: ${busLocation.timestamp}"),
              ],
            ),
          );
        },
      ),
    );
  }
}