import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/di/service_locator.dart';
import '../../../features/tracking/domain/bus_location.dart';
import '../../../features/tracking/domain/eta_calculator.dart';
import '../../../core/location/passenger_location_service.dart';

class TrackBusScreen extends StatefulWidget {
  const TrackBusScreen({super.key});

  @override
  State<TrackBusScreen> createState() => _TrackBusScreenState();
}

class _TrackBusScreenState extends State<TrackBusScreen> {
  final String busId = "bus_101";

  double? passengerLat;
  double? passengerLng;

  @override
  void initState() {
    super.initState();
    _loadPassengerLocation();
  }

  Future<void> _loadPassengerLocation() async {
    try {
      final locationService = PassengerLocationService();
      final position = await locationService.getCurrentLocation();

      setState(() {
        passengerLat = position.latitude;
        passengerLng = position.longitude;
      });
    } catch (e) {
      debugPrint("Location Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (passengerLat == null || passengerLng == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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

          final distance = EtaCalculator.calculateDistance(
            busLocation.latitude,
            busLocation.longitude,
            passengerLat!,
            passengerLng!,
          );

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
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Distance: ${distance.toStringAsFixed(2)} km",
                      ),
                      const SizedBox(height: 8),
                      Text(
                        busLocation.speed <= 0
                            ? "ETA: Waiting for speed data..."
                            : "ETA: ${eta.toStringAsFixed(1)} minutes",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Speed: ${busLocation.speed} km/h"),
                      Text("Status: ${busLocation.status}"),
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
