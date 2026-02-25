import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../driver_screen.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();

  bool loading=false;

  Future loginDriver() async {

    setState(()=>loading=true);

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const DriverScreen()));

    }catch(e){

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Driver Login Failed")));

    }

    setState(()=>loading=false);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Driver Login")),

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(Icons.drive_eta,size:80,color:Colors.blue),

            const SizedBox(height:20),

            TextField(
              controller: email,
              decoration: const InputDecoration(
                  labelText:"Driver Email"),
            ),

            const SizedBox(height:15),

            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText:"Password"),
            ),

            const SizedBox(height:25),

            ElevatedButton(

              onPressed: loading?null:loginDriver,

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),

            )

          ],
        ),
      ),
    );
  }
}
