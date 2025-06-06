// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import your data and state management components
import 'package:monthly/data/database_helper.dart';
import 'package:monthly/state_management/transaction_notifier.dart';
import 'package:monthly/state_management/account_notifier.dart';
import 'package:monthly/state_management/category_notifier.dart';

// Import your app's screens
import 'package:monthly/screens/dashboard_screen.dart';
import 'package:monthly/screens/add_transaction_screen.dart'; // Import for the new screen
import 'package:monthly/theme/app_theme.dart';

// Imports for desktop database support (sqflite_common_ffi)
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform; // Used to check the operating system

void main() async {
  // Ensure Flutter widgets are initialized before anything else
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for desktop platforms (Windows, Linux, macOS)
  // This must be done before using sqflite on desktop.
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Initialize the FFI loader
    databaseFactory =
        databaseFactoryFfi; // Set the default database factory to FFI
  }

  // Initialize the database helper as a singleton
  // This will open the database and create tables if they don't exist.
  await DatabaseHelper().database;

  runApp(
    // MultiProvider allows us to provide multiple notifiers (state managers)
    // to the widget tree, making them accessible to all child widgets.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionNotifier()),
        ChangeNotifierProvider(create: (_) => AccountNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        // Add more providers here for other state management classes as needed
      ],
      child: const MonthlyApp(), // Your main application widget
    ),
  );
}

class MonthlyApp extends StatelessWidget {
  const MonthlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly', // The title displayed in the task manager/app switcher
      theme: AppTheme.lightTheme, // Light theme configuration
      darkTheme: AppTheme.darkTheme, // Dark theme configuration
      themeMode:
          ThemeMode.system, // Use the system's theme preference (light/dark)
      // Use named routes for navigation within the app
      initialRoute: '/', // The initial route that loads when the app starts
      routes: {
        '/': (context) =>
            const DashboardScreen(), // Dashboard is the home screen
        '/add_transaction': (context) =>
            const AddTransactionScreen(), // Route for adding a new transaction
        // Add more routes here for other screens like '/transactions_list', '/budgets', etc.
      },
    );
  }
}
