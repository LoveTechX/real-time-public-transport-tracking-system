import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  GoogleMapController? _mapController;
  LatLng? _lastBusPosition;

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
      body: StreamBuilder<BusLocation>(
        stream: ServiceLocator.trackingController.getBusLocation(busId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final busLocation = snapshot.data!;

          final LatLng busPosition =
              LatLng(busLocation.latitude, busLocation.longitude);

          final bool isOffline = busLocation.status == "offline";

          // ✅ Safe int calculation
          final int nowMillis = DateTime.now().toUtc().millisecondsSinceEpoch;

          final int diffSeconds =
              ((nowMillis - busLocation.timestampMillis) ~/ 1000)
                  .clamp(0, 9999)
                  .toInt();

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

          // Smooth follow
          if (_lastBusPosition == null || _lastBusPosition != busPosition) {
            _lastBusPosition = busPosition;
            _mapController?.animateCamera(
              CameraUpdate.newLatLng(busPosition),
            );
          }

          return Stack(
            children: [
              /// GOOGLE MAP
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: busPosition,
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("bus"),
                    position: busPosition,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      isOffline
                          ? BitmapDescriptor.hueOrange
                          : BitmapDescriptor.hueRed,
                    ),
                  ),
                  Marker(
                    markerId: const MarkerId("passenger"),
                    position: LatLng(passengerLat!, passengerLng!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
              ),

              /// TOP STATUS CARD
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: isOffline ? Colors.red : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Bus $busId • ${isOffline ? "Offline" : "Live"}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Last updated ${diffSeconds}s ago",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// BOTTOM SHEET
              DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.2,
                maxChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "ETA: ${eta.toStringAsFixed(1)} min",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Distance: ${distance.toStringAsFixed(2)} km",
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Speed: ${busLocation.speed.toStringAsFixed(1)} km/h",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
