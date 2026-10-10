import 'package:flutter/material.dart';
import 'package:project2/core/Routing/routes.dart';
import 'package:project2/ui.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Care Connect')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const IntroCard(
              title: 'A little care, a lot closer.',
              subtitle:
                  'Explore specialists and plan an appointment in a few simple steps.',
              icon: Icons.health_and_safety_outlined,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Find your specialist'),
                subtitle: Text('Browse a small sample doctor directory'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.calendar_month_outlined),
                title: Text('Choose your time'),
                subtitle: Text('Pick a date and an appointment slot'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.favorite_outline),
                title: Text('Keep it simple'),
                subtitle: Text(
                  'Your bookings are available during this session',
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pushNamed(context, Routes.loginScreen),
              child: const Text('Get started'),
            ),
          ],
        ),
      ),
    ),
  );
}
