// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'bmicalculator.dart';

void main() => runApp(myapp());

// ignore: camel_case_types
class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: BMICalculator(),
    );
  }
}
