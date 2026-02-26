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

  bool isTracking = false;

  final String busId = "bus_101";

  final LatLng startPoint = const LatLng(31.3260, 75.5762);

  Future<void> startTrip() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    setState(() => isTracking = true);

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    ).listen((Position position) async {

      await FirebaseFirestore.instance
          .collection('buses')
          .doc(busId)
          .set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'speed': position.speed * 3.6, // m/s to km/h
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

  Future<void> stopTrip() async {
    await positionStream?.cancel();

    await FirebaseFirestore.instance
        .collection('buses')
        .doc(busId)
        .update({
      'status': 'offline',
    });

    setState(() => isTracking = false);
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

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