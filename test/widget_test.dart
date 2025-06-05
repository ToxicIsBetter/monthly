// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:monthly/main.dart'; // Import your main app file
import 'package:monthly/screens/dashboard_screen.dart'; // Import your dashboard screen if you want to test it directly

void main() {
  testWidgets('DashboardScreen displays title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MonthlyApp()); // Use your new root widget

    // Verify that our DashboardScreen has the correct title.
    expect(find.text('Monthly Dashboard'), findsOneWidget);
    expect(
      find.text('Welcome to Monthly! Your budgeting journey starts here.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.add), findsOneWidget); // Check for the FAB

    // Optionally, if you wanted to test the DashboardScreen directly:
    // await tester.pumpWidget(
    //   const MaterialApp( // Wrap in MaterialApp because DashboardScreen uses Scaffold, which needs Material ancestors
    //     home: DashboardScreen(),
    //   ),
    // );
    // expect(find.text('Monthly Dashboard'), findsOneWidget);
  });
}
