// lib/data/repositories/transaction_repository.dart
import 'package:monthly/data/database_helper.dart';
import 'package:monthly/models/transaction.dart';

class TransactionRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper(); // Get the singleton instance

  // Constructor (optional, but good for explicit dependencies)
  // TransactionRepository({DatabaseHelper? databaseHelper})
  //     : _databaseHelper = databaseHelper ?? DatabaseHelper();

  Future<int> insertTransaction(Transaction transaction) async {
    return await _databaseHelper.insertTransaction(transaction);
  }

  Future<List<Transaction>> getTransactions() async {
    return await _databaseHelper.getTransactions();
  }

  Future<int> updateTransaction(Transaction transaction) async {
    return await _databaseHelper.updateTransaction(transaction);
  }

  Future<int> deleteTransaction(String id) async {
    return await _databaseHelper.deleteTransaction(id);
  }
}
