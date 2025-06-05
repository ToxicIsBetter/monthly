// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Dashboard')),
      body: const Center(
        child: Text('Welcome to Monthly! Your budgeting journey starts here.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Transaction screen later
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new transaction (Coming Soon)!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
