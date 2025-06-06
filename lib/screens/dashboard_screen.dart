// lib/screens/dashboard_screen.dart
// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Dashboard'),
        // Apply theme colors for the app bar
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: const Center(
        child: Text(
          'Welcome to Monthly! Your budgeting journey starts here.',
          style: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
          ), // Added a bit of style
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddTransactionScreen using its named route
          Navigator.of(context).pushNamed('/add_transaction');
        },
        child: const Icon(Icons.add),
        // Apply theme colors for the Floating Action Button
        backgroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.backgroundColor,
        foregroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.foregroundColor,
      ),
    );
  }
}
