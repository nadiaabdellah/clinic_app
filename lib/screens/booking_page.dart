import 'package:clinic_app/Models/doctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:clinic_app/screens/appointmentspage.dart';

class Booking extends StatefulWidget {
  final Doctor doctor;

  const Booking({super.key, required this.doctor});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController reasonForVisit = TextEditingController();

  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2029),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickTime != null) {
      setState(() {
        selectedTime = pickTime;
      });
    }
  }

  Future<void> saveBooking() async {
    final user = FirebaseAuth.instance.currentUser!;
    final d = selectedDate!;
    final t = selectedTime!;
    await FirebaseFirestore.instance.collection('appointments').add({
      'userId': user.uid,
      'doctorId': widget.doctor.id,
      'doctorName': widget.doctor.name,
      'specialty': widget.doctor.specialty,
      'image': widget.doctor.image,
      'date': Timestamp.fromDate(
        DateTime(d.year, d.month, d.day, t.hour, t.minute),
      ),
      'reason': reasonForVisit.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MyAppointmentsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.doctor.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.doctor.specialty,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.doctor.image),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickDate,
              child: const Text("Select Date"),
            ),
            ElevatedButton(
              onPressed: pickTime,
              child: const Text("Select Time"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: reasonForVisit,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Enter the reason for your visit",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedDate == null || selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select day and time "),
                    ),
                  );
                  return;
                }
                saveBooking();
              },
              child: const Text("Booking now"),
            ),
          ],
        ),
      ),
    );
  }
}