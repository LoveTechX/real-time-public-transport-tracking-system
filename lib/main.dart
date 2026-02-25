import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Main Screens
import 'screens/role_selection_screen.dart';
import 'screens/passenger_screen.dart';
import 'screens/driver_screen.dart';
import 'screens/conductor_screen.dart';

/// Passenger Screens
import 'screens/passenger/routes_screen.dart';
import 'screens/passenger/ticket_screen.dart';
import 'screens/passenger/schedule_screen.dart';
import 'screens/passenger/profile_screen.dart';
import 'screens/passenger/history_screen.dart';
import 'screens/passenger/alerts_screen.dart';
import 'screens/passenger/mytickets_screen.dart';
import 'screens/passenger/track_bus_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Smart Transport System",

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),

      /// First Screen
      home: const RoleSelectionScreen(),

      routes: {

        /// Roles
        '/passenger': (context) => const PassengerScreen(),
        '/driver': (context) => const DriverScreen(),
        '/conductor': (context) => const ConductorScreen(),

        /// Passenger Features
        '/routes': (context) => const RoutesScreen(),
        '/tickets': (context) => const TicketScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/history': (context) => const HistoryScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/mytickets': (context) => const MyTicketsScreen(),
        '/trackbus': (context) => const TrackBusScreen(),

      },

    );
  }
}