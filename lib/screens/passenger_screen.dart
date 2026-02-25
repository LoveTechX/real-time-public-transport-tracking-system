import 'package:flutter/material.dart';

class PassengerScreen extends StatelessWidget {
  const PassengerScreen({super.key});

  Widget buildOption(
      BuildContext context,
      String title,
      IconData icon,
      String route,
      ) {
    return GestureDetector(

      onTap: () {
        Navigator.pushNamed(context, route);
      },

      child: Container(

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0,3),
            )
          ],
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 28,
              color: Colors.indigo,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Passenger Dashboard"),
        elevation: 0,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// Header

            const Text(
              "Smart Transport",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Passenger Panel",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// Grid Options

            Expanded(

              child: GridView.count(

                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,

                children: [

                  buildOption(
                      context,
                      "Track Bus",
                      Icons.location_on,
                      '/trackbus'),

                  buildOption(
                      context,
                      "Routes",
                      Icons.alt_route,
                      '/routes'),

                  buildOption(
                      context,
                      "Tickets",
                      Icons.confirmation_number,
                      '/tickets'),

                  buildOption(
                      context,
                      "My Tickets",
                      Icons.receipt_long,
                      '/mytickets'),

                  buildOption(
                      context,
                      "Schedule",
                      Icons.schedule,
                      '/schedule'),

                  buildOption(
                      context,
                      "History",
                      Icons.history,
                      '/history'),

                  buildOption(
                      context,
                      "Alerts",
                      Icons.notifications,
                      '/alerts'),

                  buildOption(
                      context,
                      "Profile",
                      Icons.person,
                      '/profile'),

                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}