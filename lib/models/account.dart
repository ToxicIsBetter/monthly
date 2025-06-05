// lib/models/account.dart
class Account {
  final String id;
  final String name;
  final double initialBalance;
  double currentBalance; // Can change

  Account({
    required this.id,
    required this.name,
    required this.initialBalance,
    required this.currentBalance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initialBalance': initialBalance,
      'currentBalance': currentBalance,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      initialBalance: map['initialBalance'],
      currentBalance: map['currentBalance'],
    );
  }
}
