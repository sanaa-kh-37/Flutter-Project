// ignore: unused_import
// ignore_for_file: prefer_interpolation_to_compose_strings, sort_child_properties_last, non_constant_identifier_names, unused_import, duplicate_ignore, use_super_parameters

import 'package:project/bmicalculator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);
  @override
  BMICalState createState() => BMICalState();
}

class BMICalState extends State<BMICalculator> {
  Color c1 = Colors.transparent;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  var mainResult = TextEditingController();

  void calculate_BMI(String weight, String height) async {
    var myweight = double.parse(weight);
    var myheight = double.parse(height);
     myheight = myheight / 100; // convert cm → meters
    var result = (myweight / (myheight * myheight));

    setState(() {
      mainResult.text = result.toStringAsFixed(2);
      if (result < 18.5) {
        c1 = Colors.red;
      } else if (result >= 18.5 && result <= 24.9) {
        c1 = Colors.green;
      } else if (result >= 25 && result <= 29.9) {
        c1 = Colors.pink;
      } else if (result >= 30 && result <= 34.9) {
        c1 = Colors.orange;
      } else if (result >= 35) {
        c1 = Colors.red;
      }
    });
    // === ADD THIS CODE AFTER setState ===
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String category = "Unknown";
      if (result < 18.5) category = "Underweight";
      else if (result <= 24.9) category = "Normal";
      else if (result <= 29.9) category = "Overweight";
      else if (result <= 34.9) category = "Obese";
      else category = "Extreme";

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('bmi_history')
          .add({
        'weight': myweight,
        'height': myheight * 100, // save in cm
        'bmi': result,
        'category': category,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          backgroundColor: Colors.brown,

          // 👇 BACK BUTTON
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
        ),

        body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFD9B39C), const Color(0xFF8D5524)],
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D0D0D),
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsetsGeometry.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF5F5DC),
                        hintText: "enter your weight(kg)",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: TextField(
                      controller: heightController,
                      autofocus: false,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF5F5DC),
                        hintText: "enter your height:(cm)",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            calculate_BMI(
                              weightController.text,
                              heightController.text,
                            );
                          },
                          child: const Text(
                            "calculate",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.brown,
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        color: c1,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                  //     child: Center(
                  //       child: Text(
                  //         "BMI:" + mainResult.text,
                  //         style: TextStyle(
                  //           fontSize: 25,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 80),
                  // Center(
                  //   child: Container(
                  //     width: 300,
                  //     height: 100,
                  //     decoration: BoxDecoration(
                  //       color: c1,
                  //       borderRadius: BorderRadius.all(Radius.circular(12)),
                  //     ),
                      child: Center(
                        child: Text(
                          "BMI:" + mainResult.text,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryIndicator(
                          Colors.red,
                          "underweight",
                        ),
                        _buildCategoryIndicator(Colors.green, "normal"),
                        _buildCategoryIndicator(
                          Colors.pink,
                          "overweight",
                        ),
                        _buildCategoryIndicator(Colors.orange, "obese"),
                        _buildCategoryIndicator(Colors.red, "extreme"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIndicator(Color color, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
