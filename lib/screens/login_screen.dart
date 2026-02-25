import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> loginUser() async {

    setState(() => loading = true);

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed"))
      );

    }

    setState(() => loading = false);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xff4A90E2),
              Color(0xff357ABD)
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            child: Padding(

              padding: const EdgeInsets.all(25),

              child: Container(

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 15,
                      color: Colors.black12,
                    )
                  ],

                ),

                child: Column(

                  children: [

                    const Icon(
                      Icons.directions_bus,
                      size: 80,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Smart Transport",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(

                      controller: emailController,

                      decoration: InputDecoration(

                        labelText: "Email",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(

                      controller: passwordController,
                      obscureText: true,

                      decoration: InputDecoration(

                        labelText: "Password",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          padding: const EdgeInsets.all(15),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                        ),

                        onPressed: loading ? null : loginUser,

                        child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16),
                        ),

                      ),
                    ),

                    const SizedBox(height: 15),

                    const Divider(),

                    const SizedBox(height: 10),

                    const Text("OR"),

                    const SizedBox(height: 10),

                    SizedBox(

                      width: double.infinity,

                      child: OutlinedButton.icon(

                        icon: const Icon(Icons.login),

                        label: const Text("Login with Google"),

                        onPressed: () {},

                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton(

                      onPressed: () {},

                      child: const Text("Create Account"),

                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}