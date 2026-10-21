# Nova Clinic 🩺

A Flutter mobile app for booking doctor appointments, built with Firebase.

> 🎓 **Educational project.** This app was created for learning purposes to practice Flutter and Firebase. It is **not** a real medical service and must not be used for real medical appointments or advice.

> ⚠️ **Status: Work in progress.** The app is still under development, and its design and features are being improved and updated regularly.

## Overview
Nova Clinic lets users create an account, browse doctors, view their details, and book appointments. Bookings are stored in the cloud and can be viewed or cancelled anytime.

## What I'm Learning
- Building multi-screen Flutter apps (navigation, forms, lists)
- Firebase Authentication (register and login)
- Cloud Firestore (saving, reading, and deleting data)
- Organizing a project into folders and files

## Current Features
- Register and login with email and password
- Doctors list with specialty, city, and rating
- Doctor details page
- Book an appointment (date, time, and reason for visit)
- My appointments page, with the option to cancel

## Tech Stack
- Flutter and Dart
- Firebase Authentication
- Cloud Firestore

## Project Structure
    lib/
    ├── main.dart
    ├── Models/       # Data models
    ├── data/         # Sample doctors data
    ├── screens/      # App pages
    └── widgets/      # Reusable widgets

## Planned Improvements
- Auto-login and logout
- Load doctors from Firestore
- Firestore security rules
- Improved UI design
- Better error messages and input validation

## Note on Data
The doctors shown in the app are **sample data for demonstration only**. They do not represent real clinic staff or real availability.

## Getting Started
1. Clone the repository
2. Run `flutter pub get`
3. Connect your own Firebase project (`flutterfire configure`)
4. Run `flutter run`