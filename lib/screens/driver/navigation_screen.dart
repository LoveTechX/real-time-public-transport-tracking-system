import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  GoogleMapController? mapController;

  final LatLng startPoint = const LatLng(31.3260, 75.5762);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Driver Navigation"),
      ),

      body: GoogleMap(

        initialCameraPosition: CameraPosition(
          target: startPoint,
          zoom: 14,
        ),

        onMapCreated: (controller){
          mapController = controller;
        },

        markers: {

          Marker(
            markerId: const MarkerId("bus"),
            position: startPoint,
          )

        },

      ),

    );
  }
}