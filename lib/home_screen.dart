import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bmicalculator.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFD9B39C), Color(0xFF8D5524)]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Welcome
              Text(
                "Welcome, ${user?.email?.split('@')[0] ?? 'User'} ",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Big Calculate Button
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BMICalculator()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "Calculate Your BMI",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // History Title
              const Text(
                "Your BMI History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),

              // History List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .collection('bmi_history')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return const Center(
                        child: Text("No history yet.\nCalculate your first BMI!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                      );
                    }
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        final bmi = data['bmi'].toStringAsFixed(1);
                        final Timestamp? ts = data['timestamp'];
                        final DateTime date = ts?.toDate() ?? DateTime.now();
                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text("BMI: $bmi", style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("${data['category']} • ${date.day}/${date.month}/${date.year}"),
                            leading: const Icon(Icons.monitor_weight, color: Colors.brown),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}