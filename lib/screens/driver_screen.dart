import 'package:flutter/material.dart';
import 'driver/navigation_screen.dart';
import 'driver/trips_screen.dart';
import 'driver/bus_status_screen.dart';
import 'driver/settings_screen.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  bool dutyStarted = false;

  /// START DUTY
  void startDuty() {

    setState(() {
      dutyStarted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Duty Started"),
      ),
    );
  }

  /// STOP DUTY
  void stopDuty() {

    setState(() {
      dutyStarted = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Duty Stopped"),
      ),
    );
  }

  /// HELP SCREEN
  void showHelp() {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Emergency Help"),

          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                leading: Icon(Icons.phone),
                title: Text("Customer Care"),
                subtitle: Text("1800-123-456"),
              ),

              ListTile(
                leading: Icon(Icons.local_police),
                title: Text("Police"),
                subtitle: Text("100"),
              ),

              ListTile(
                leading: Icon(Icons.local_hospital),
                title: Text("Ambulance"),
                subtitle: Text("102"),
              ),

              ListTile(
                leading: Icon(Icons.fire_truck),
                title: Text("Fire Brigade"),
                subtitle: Text("101"),
              ),

            ],
          ),

          actions: [

            TextButton(

              onPressed: (){
                Navigator.pop(context);
              },

              child: const Text("Close"),
            )

          ],
        );
      },
    );
  }


  /// GRID BUTTON
  Widget buildBox(
      String title,
      IconData icon,
      VoidCallback onTap
      ){

    return GestureDetector(

      onTap: onTap,

      child: Container(

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(2,2),
            )

          ],

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 35,
              color: Colors.indigo,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
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

        title: const Text("Driver Dashboard"),

        backgroundColor: Colors.indigo,

      ),

      body: Column(

        children: [

          /// STATUS CARD

          Container(

            margin: const EdgeInsets.all(15),

            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(

              color: Colors.indigo,

              borderRadius: BorderRadius.circular(15),

            ),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                const Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Bus No: PB10-1234",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Driver Mode",
                      style: TextStyle(
                          color: Colors.white70
                      ),
                    ),

                  ],
                ),

                Icon(
                  dutyStarted
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: Colors.white,
                  size: 35,
                )

              ],
            ),

          ),

          /// BUTTON GRID

          Expanded(

            child: GridView.count(

              padding: const EdgeInsets.all(15),

              crossAxisCount: 2,

              mainAxisSpacing: 15,

              crossAxisSpacing: 15,

              children: [

                buildBox(
                    "Start Duty",
                    Icons.play_arrow,
                    startDuty
                ),

                buildBox(
                    "Stop Duty",
                    Icons.stop,
                    stopDuty
                ),

                buildBox(
                    "Navigation",
                    Icons.navigation,
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>const NavigationScreen()
                          )
                      );
                    }
                ),

                buildBox(
                    "Bus Status",
                    Icons.directions_bus,
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>const BusStatusScreen()
                          )
                      );
                    }
                ),

                buildBox(
                    "Trips",
                    Icons.route,
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>const TripsScreen()
                          )
                      );
                    }
                ),

                buildBox(
                    "Settings",
                    Icons.settings,
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>const SettingsScreen()
                          )
                      );
                    }
                ),

                buildBox(
                    "Help",
                    Icons.support_agent,
                    showHelp
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}