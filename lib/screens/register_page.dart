import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'doctors_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailACC = TextEditingController();
  final TextEditingController passAcc = TextEditingController();
  final TextEditingController confPASS = TextEditingController();
  bool loading = false;

  Future<void> register() async {
    setState(() => loading = true);
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailACC.text.trim(),
        password: passAcc.text.trim(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
        'name': name.text.trim(),
        'email': emailACC.text.trim(),
      });
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Doctors()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Create A new an account"),
            TextFormField(
              controller: name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter your name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: emailACC,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter Your Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: passAcc,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter the Passowrd";
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Passowrd",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            TextFormField(
              controller: confPASS,
              validator: (value) {
                if (value == null || value.isEmpty || value != passAcc.text) {
                  return "Passowrd unconfrmity ";
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: " Confirm passowrd",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) register();
                    },
                    child: const Text("Create Account"),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}