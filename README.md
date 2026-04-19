### BMI Calculator Flutter App

A Flutter application that allows users to register, log in, calculate Body Mass Index (BMI), and store BMI history using Firebase Authentication and Cloud Firestore. This project demonstrates Flutter UI development and Firebase backend integration.

### Features

## User Authentication

- Register a new account using email and password
- Log in securely
- Log out functionality

### BMI Calculator

- Calculates BMI using height and weight inputs
- Displays BMI category with visual color indicators

### Cloud Firestore Integration

- Saves BMI results for each authenticated user
- Displays real-time BMI history
- Timestamped records

### User Interface

- Gradient themed interface
- Structured navigation flow
- Responsive layout
- Application Flow:

Login / Register → Home Screen → Calculate BMI → Save to Firestore → View BMI History

## Technologies Used

- Flutter (Dart)
- Firebase Authentication
- Cloud Firestore
- Material Design

## Project Structure:

lib/
│
├── splash_screen.dart
├── login_screen.dart
├── register_screen.dart
├── home_screen.dart
└── bmicalculator.dart

## BMI Formula

BMI = weight(kg) / height(m)^2

## BMI Categories:

- < 18.5	Underweight
- 18.5 – 24.9	Normal
- 25 – 29.9	Overweight
- 30 – 34.9	Obese
- 35+	Extreme

## Firebase Setup

To run the project locally:

- Create a Firebase project
- Enable Authentication → Email/Password
- Enable Cloud Firestore
- Add an Android app in Firebase Console
- Download google-services.json and place it in:
  android/app/
- Install dependencies and run the project:
  flutter pub get
  flutter run

## Running the Project from GitHub:

- git clone https://github.com/sanaa-kh-37/Flutter-Project.git
- cd bmi-calculator-flutter
- flutter pub get
- flutter run

This project demonstrates the integration of Flutter with Firebase Authentication and Cloud Firestore to build a complete, user-focused mobile application. It serves as a practical foundation for learning modern mobile development, state management, and cloud-based data storage.
