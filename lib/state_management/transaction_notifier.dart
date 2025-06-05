// lib/state_management/transaction_notifier.dart
import 'package:flutter/material.dart';
// import 'package:monthly/models/transaction.dart'; // Will use later
// import 'package:monthly/data/repositories/transaction_repository.dart'; // Will use later

class TransactionNotifier extends ChangeNotifier {
  // List<Transaction> _transactions = []; // Will store transactions here

  TransactionNotifier() {
    // _loadTransactions(); // Call this when the notifier is created
  }

  // Future<void> _loadTransactions() async {
  //   _transactions = await TransactionRepository().getTransactions();
  //   notifyListeners();
  // }

  // Example for adding:
  // Future<void> addTransaction(Transaction transaction) async {
  //   await TransactionRepository().insertTransaction(transaction);
  //   _transactions.add(transaction);
  //   notifyListeners();
  // }

  // Add methods for other CRUD operations and data manipulation
}
