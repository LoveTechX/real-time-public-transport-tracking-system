import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Book Ticket"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// From Location
            TextField(
              decoration: InputDecoration(
                labelText: "From",
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// To Location
            TextField(
              decoration: InputDecoration(
                labelText: "To",
                prefixIcon: const Icon(Icons.location_pin),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Date
            TextField(
              decoration: InputDecoration(
                labelText: "Travel Date",
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Book Button
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ticket Booked Successfully"),
                    ),
                  );

                },

                child: const Text(
                  "Book Ticket",
                  style: TextStyle(fontSize: 18),
                ),

              ),
            ),

            const SizedBox(height: 30),

            /// Ticket Info Card
            Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              elevation: 3,

              child: const Padding(

                padding: EdgeInsets.all(16),

                child: Column(

                  children: [

                    Text(
                      "Sample Ticket",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("Bus No : PB10-1021"),
                    Text("Seat : 12"),
                    Text("Fare : ₹25"),

                  ],

                ),

              ),

            )

          ],

        ),

      ),

    );

  }
}