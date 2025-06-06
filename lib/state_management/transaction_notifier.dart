// lib/state_management/transaction_notifier.dart
import 'package:flutter/material.dart';
import 'package:monthly/data/repositories/transaction_repository.dart'; // Import the repository
import 'package:monthly/models/transaction.dart'; // Import your Transaction model

class TransactionNotifier extends ChangeNotifier {
  final TransactionRepository _repository =
      TransactionRepository(); // Get the repository instance

  List<Transaction> _transactions = []; // Private list to hold transactions
  List<Transaction> get transactions =>
      _transactions; // Public getter to access transactions

  // Constructor: Load transactions when the notifier is created
  TransactionNotifier() {
    _loadTransactions();
  }

  // Method to load transactions from the database
  Future<void> _loadTransactions() async {
    _transactions = await _repository.getTransactions();
    notifyListeners(); // Notify widgets that depend on this notifier to rebuild
  }

  // Method to add a new transaction
  Future<void> addTransaction(Transaction transaction) async {
    await _repository.insertTransaction(transaction);
    // After inserting, reload all transactions to ensure the list is fresh and ordered
    // For performance in larger apps, you might add the transaction directly and re-sort
    // but for now, a full reload is simpler and robust.
    await _loadTransactions();
  }

  // Method to update an existing transaction
  Future<void> updateTransaction(Transaction transaction) async {
    await _repository.updateTransaction(transaction);
    await _loadTransactions(); // Reload to update the list
  }

  // Method to delete a transaction
  Future<void> deleteTransaction(String id) async {
    await _repository.deleteTransaction(id);
    await _loadTransactions(); // Reload to update the list
  }

  // You can add more methods here later, like:
  // - getTransactionsForMonth(DateTime date)
  // - getTotalIncome()
  // - getTotalExpense()
  // - getBalance()
  // ... and so on
}
