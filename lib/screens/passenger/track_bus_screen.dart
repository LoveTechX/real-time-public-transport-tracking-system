import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/di/service_locator.dart';
import '../../../features/tracking/domain/bus_location.dart';
import '../../../features/tracking/domain/eta_calculator.dart';

class TrackBusScreen extends StatelessWidget {
  const TrackBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String busId = "bus_101";

    return Scaffold(
      appBar: AppBar(title: const Text("Track Bus")),
      body: StreamBuilder<BusLocation>(
        stream: ServiceLocator.trackingController.getBusLocation(busId),
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
          final LatLng position =
              LatLng(busLocation.latitude, busLocation.longitude);

          // Temporary passenger location (we will replace with real GPS later)
          const passengerLat = 30.6900;
          const passengerLng = 76.6600;

// Calculate distance
          final distance = EtaCalculator.calculateDistance(
            busLocation.latitude,
            busLocation.longitude,
            passengerLat,
            passengerLng,
          );

// Calculate ETA
          final eta = EtaCalculator.calculateEtaMinutes(
            distance,
            busLocation.speed,
          );

          return Column(
            children: [
              Expanded(
                flex: 3,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: position,
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName:
                          "com.example.smart_transport_system",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: position,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.directions_bus,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ETA PANEL
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Distance: ${distance.toStringAsFixed(2)} km",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        busLocation.speed <= 0
                            ? "ETA: Waiting for speed data..."
                            : "ETA: ${eta.toStringAsFixed(1)} minutes",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Speed: ${busLocation.speed} km/h",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Status: ${busLocation.status}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
