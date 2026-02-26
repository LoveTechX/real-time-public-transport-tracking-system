import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;
  Timer? heartbeatTimer;

  bool isTracking = false;

  final String busId = "bus_101";
  final LatLng startPoint = const LatLng(31.3260, 75.5762);

  // 🔥 START TRIP
  Future<void> startTrip() async {
    if (isTracking) return; // prevent double start

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    setState(() => isTracking = true);

    // ✅ Heartbeat: keeps bus online even if GPS doesn't update
    heartbeatTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) async {
        await FirebaseFirestore.instance.collection('buses').doc(busId).update({
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'online',
        });
      },
    );

    // ✅ Location Stream
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    ).listen((Position position) async {
      await FirebaseFirestore.instance.collection('buses').doc(busId).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'speed': position.speed * 3.6,
        'status': 'online',
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  // 🔥 STOP TRIP
  Future<void> stopTrip() async {
    if (!isTracking) return;

    heartbeatTimer?.cancel();
    heartbeatTimer = null;

    await positionStream?.cancel();
    positionStream = null;

    await FirebaseFirestore.instance.collection('buses').doc(busId).update({
      'status': 'offline',
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() => isTracking = false);
  }

  // 🔥 CLEANUP
  @override
  void dispose() {
    heartbeatTimer?.cancel();
    positionStream?.cancel();
    super.dispose();
  }

  // 🔥 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Navigation"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: startPoint,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: isTracking ? stopTrip : startTrip,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                isTracking ? "Stop Trip" : "Start Trip",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
