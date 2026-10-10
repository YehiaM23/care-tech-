import 'package:flutter/material.dart';
import 'package:project2/ui.dart';
import 'doctor_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController(), email = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Your profile')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const IntroCard(
              title: 'Nice to meet you.',
              subtitle: 'Enter your details to try the appointment demo.',
              icon: Icons.person_outline,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: 'Your name'),
                    validator: (v) =>
                        (v ?? '').trim().length < 2 ? 'Enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (v) =>
                        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v ?? '')
                        ? 'Enter a valid email'
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorScreen(name: name.text.trim()),
                    ),
                  );
                }
              },
              child: const Text('Browse doctors'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'This is a local demo. No account or real appointment is created.',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
