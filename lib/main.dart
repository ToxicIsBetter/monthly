// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:monthly/data/database_helper.dart'; // Import your database helper
import 'package:monthly/state_management/transaction_notifier.dart'; // Will create this soon
import 'package:monthly/state_management/account_notifier.dart'; // Will create this soon
import 'package:monthly/state_management/category_notifier.dart'; // Will create this soon
import 'package:monthly/screens/dashboard_screen.dart'; // Will create this soon
import 'package:monthly/theme/app_theme.dart'; // Will create this soon

import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import for desktop FFI
import 'dart:io' show Platform; // For checking the platform (part of dart:io)

void main() async {
  // Ensure Flutter is initialized before anything else
  WidgetsFlutterBinding.ensureInitialized();

  // --- CONDITIONAL INITIALIZATION FOR DESKTOP ---
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI for desktop platforms
    sqfliteFfiInit();
    // Change the default factory to the ffi factory
    databaseFactory = databaseFactoryFfi;
  }
  // --- END CONDITIONAL INITIALIZATION ---

  // Initialize the database helper as a singleton
  await DatabaseHelper().database; // This will open/create the DB

  runApp(
    // MultiProvider allows us to provide multiple notifiers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionNotifier()),
        ChangeNotifierProvider(create: (_) => AccountNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        // Add more providers here for other state management classes
      ],
      child: const MonthlyApp(),
    ),
  );
}

class MonthlyApp extends StatelessWidget {
  const MonthlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly', // Your app's official name
      theme: AppTheme.lightTheme, // Using a custom theme (will create this)
      darkTheme: AppTheme.darkTheme, // Optional dark theme
      themeMode: ThemeMode.system, // Follow system preference
      home: const DashboardScreen(), // Your main starting screen
      // Define your routes here later
      // routes: {
      //   '/add_transaction': (context) => const AddTransactionScreen(),
      //   // ... other routes
      // },
    );
  }
}
