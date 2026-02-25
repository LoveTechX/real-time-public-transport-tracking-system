import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/role_selection_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';

import '../../screens/passenger_screen.dart';
import '../../screens/driver_screen.dart';
import '../../screens/conductor_screen.dart';

import '../../screens/passenger/routes_screen.dart';
import '../../screens/passenger/ticket_screen.dart';
import '../../screens/passenger/schedule_screen.dart';
import '../../screens/passenger/profile_screen.dart';
import '../../screens/passenger/history_screen.dart';
import '../../screens/passenger/alerts_screen.dart';
import '../../screens/passenger/mytickets_screen.dart';
import '../../screens/passenger/track_bus_screen.dart';

class AppRouter {
  // Core Routes
  static const splash = '/';
  static const login = '/login';
  static const roleSelection = '/role-selection';

  // Role Routes
  static const passenger = '/passenger';
  static const driver = '/driver';
  static const conductor = '/conductor';

  // Passenger Feature Routes
  static const routesScreen = '/routes';
  static const tickets = '/tickets';
  static const schedule = '/schedule';
  static const profile = '/profile';
  static const history = '/history';
  static const alerts = '/alerts';
  static const myTickets = '/mytickets';
  static const trackBus = '/trackbus';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case passenger:
        return MaterialPageRoute(builder: (_) => const PassengerScreen());

      case driver:
        return MaterialPageRoute(builder: (_) => const DriverScreen());

      case conductor:
        return MaterialPageRoute(builder: (_) => const ConductorScreen());

      case routesScreen:
        return MaterialPageRoute(builder: (_) => const RoutesScreen());

      case tickets:
        return MaterialPageRoute(builder: (_) => const TicketScreen());

      case schedule:
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());

      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertsScreen());

      case myTickets:
        return MaterialPageRoute(builder: (_) => const MyTicketsScreen());

      case trackBus:
        return MaterialPageRoute(builder: (_) => const TrackBusScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No Route Found')),
          ),
        );
    }
  }
}