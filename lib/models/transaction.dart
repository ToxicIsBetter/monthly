// lib/models/transaction.dart
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String type; // 'income' or 'expense'
  final String categoryId; // Link to a Category
  final String accountId; // Link to an Account
  final String? description; // Optional notes

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.accountId,
    this.description,
  });

  // Convert a Transaction object into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(), // Store DateTime as ISO string
      'type': type,
      'categoryId': categoryId,
      'accountId': accountId,
      'description': description,
    };
  }

  // Extract a Transaction object from a Map.
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'],
      categoryId: map['categoryId'],
      accountId: map['accountId'],
      description: map['description'],
    );
  }
}
