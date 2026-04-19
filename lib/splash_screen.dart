import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => user != null ? const HomeScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // (same beautiful splash as before)
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD9B39C), Color(0xFF8D5524)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.monitor_weight_outlined, size: 120, color: Colors.white),
              SizedBox(height: 20),
              Text("BMI Calculator", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text("Know your health", style: TextStyle(fontSize: 18, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}