import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../conductor_screen.dart';

class ConductorLoginScreen extends StatefulWidget {
  const ConductorLoginScreen({super.key});

  @override
  State<ConductorLoginScreen> createState() => _ConductorLoginScreenState();
}

class _ConductorLoginScreenState extends State<ConductorLoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();

  bool loading=false;

  Future login() async {

    setState(()=>loading=true);

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const ConductorScreen()));

    }catch(e){

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Login Failed")));

    }

    setState(()=>loading=false);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Conductor Login")),

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(Icons.confirmation_number,
                size:80,color:Colors.orange),

            const SizedBox(height:20),

            TextField(
              controller: email,
              decoration: const InputDecoration(
                  labelText:"Conductor Email"),
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

              onPressed: loading?null:login,

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