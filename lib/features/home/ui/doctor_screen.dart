import 'package:flutter/material.dart';
import '../data/repo.dart';
import '../data/model.dart';
import 'package:project2/ui.dart';

class DoctorScreen extends StatefulWidget {
  final String name;
  const DoctorScreen({super.key, required this.name});
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  String search = '', specialty = 'All';
  bool showBookings = false;
  final bookings = <Map<String, dynamic>>[];
  Future<void> book(Doctor doctor) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => BookingScreen(doctor: doctor)),
    );
    if (!mounted || result == null) return;
    if (bookings.any(
      (b) =>
          b['doctor'] == doctor.name &&
          b['date'] == result['date'] &&
          b['time'] == result['time'],
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You already saved this appointment.')),
      );
      return;
    }
    setState(() {
      bookings.add(result);
      showBookings = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Care Connect')),
    bottomNavigationBar: NavigationBar(
      selectedIndex: showBookings ? 1 : 0,
      onDestinationSelected: (v) => setState(() => showBookings = v == 1),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.medical_services_outlined),
          label: 'Doctors',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Appointments',
        ),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            IntroCard(
              title: showBookings
                  ? 'Your planned visits.'
                  : 'Hello, ${widget.name}.',
              subtitle: showBookings
                  ? 'Sample appointments for this session.'
                  : 'Find a specialist that fits your day.',
              icon: showBookings
                  ? Icons.calendar_month_outlined
                  : Icons.favorite_outline,
            ),
            if (showBookings) ...[
              if (bookings.isEmpty)
                const Text(
                  'No appointments yet. Browse doctors to plan a visit.',
                ),
              for (int i = 0; i < bookings.length; i++)
                Card(
                  child: ListTile(
                    title: Text(bookings[i]['doctor'] as String),
                    subtitle: Text(
                      '${bookings[i]['date']} • ${bookings[i]['time']}',
                    ),
                    trailing: IconButton(
                      tooltip: 'Cancel appointment',
                      onPressed: () => setState(() => bookings.removeAt(i)),
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ),
                ),
            ] else ...[
              TextField(
                onChanged: (v) => setState(() => search = v),
                decoration: const InputDecoration(
                  hintText: 'Search doctors',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ['All', 'General care', 'Dental', 'Dermatology']
                    .map(
                      (s) => ChoiceChip(
                        label: Text(s),
                        selected: specialty == s,
                        onSelected: (_) => setState(() => specialty = s),
                      ),
                    )
                    .toList(),
              ),
              if (!doctors.any(
                (d) =>
                    d.name.toLowerCase().contains(search.toLowerCase()) &&
                    (specialty == 'All' || specialty == d.specialty),
              ))
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No doctors match your search.'),
                ),
              for (final d in doctors)
                if (d.name.toLowerCase().contains(search.toLowerCase()) &&
                    (specialty == 'All' || specialty == d.specialty))
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              child: Icon(Icons.person_outline),
                            ),
                            title: Text(d.name),
                            subtitle: Text(d.specialty),
                          ),
                          Text(d.about),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () => book(d),
                            child: Text('Plan visit • EGP ${d.fee}'),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    ),
  );
}

class BookingScreen extends StatefulWidget {
  final Doctor doctor;
  const BookingScreen({super.key, required this.doctor});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime date = DateTime.now().add(const Duration(days: 1));
  String time = '09:00 AM';
  Future<void> chooseDate() async {
    final tomorrow = DateUtils.dateOnly(
      DateTime.now(),
    ).add(const Duration(days: 1));
    final selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: tomorrow,
      lastDate: tomorrow.add(const Duration(days: 90)),
    );
    if (mounted && selected != null) setState(() => date = selected);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Plan your visit')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        IntroCard(
          title: widget.doctor.name,
          subtitle: '${widget.doctor.specialty} • EGP ${widget.doctor.fee}',
          icon: Icons.medical_services_outlined,
        ),
        Card(
          child: ListTile(
            title: const Text('Appointment date'),
            subtitle: Text('${date.day}/${date.month}/${date.year}'),
            trailing: const Icon(Icons.calendar_month),
            onTap: chooseDate,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Choose a time',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8,
          children: ['09:00 AM', '11:00 AM', '02:00 PM', '04:00 PM']
              .map(
                (t) => ChoiceChip(
                  label: Text(t),
                  selected: time == t,
                  onSelected: (_) => setState(() => time = t),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => Navigator.pop(context, <String, dynamic>{
            'doctor': widget.doctor.name,
            'date': '${date.day}/${date.month}/${date.year}',
            'time': time,
          }),
          child: const Text('Save demo appointment'),
        ),
      ],
    ),
  );
}
