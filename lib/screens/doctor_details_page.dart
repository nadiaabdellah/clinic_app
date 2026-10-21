import 'package:clinic_app/Models/doctor.dart';
import 'package:flutter/material.dart';

import '../widgets/rating_stars.dart';
import 'booking_page.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Details")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(doctor.image),
            ),
            const SizedBox(height: 10),
            Text(
              doctor.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            RatingStars(rating: doctor.rating),
            const Divider(color: Colors.black, thickness: 1),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  "About: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(child: Text(doctor.about)),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                const Text(
                  "Specialty: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(doctor.specialty),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                const Text(
                  "City: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(doctor.city),
              ],
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Booking(doctor: doctor),
                  ),
                );
              },
              child: const Text("Book an appoinment"),
            ),
          ],
        ),
      ),
    );
  }
}