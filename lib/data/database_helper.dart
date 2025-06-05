// lib/data/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // From path_provider package

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'monthly_budget.db');

    return await openDatabase(databasePath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Transaction table
    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        title TEXT,
        amount REAL,
        date TEXT,
        type TEXT,
        categoryId TEXT,
        accountId TEXT,
        description TEXT
      )
    ''');

    // Create Category table
    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        name TEXT,
        iconCodePoint INTEGER,
        iconFontFamily TEXT,
        iconFontPackage TEXT,
        colorValue INTEGER
      )
    ''');

    // Create Account table
    await db.execute('''
      CREATE TABLE accounts(
        id TEXT PRIMARY KEY,
        name TEXT,
        initialBalance REAL,
        currentBalance REAL
      )
    ''');

    // Insert default categories and accounts here on first creation
    // This will be done in a later step!
  }

  // You will add CRUD methods here (insert, query, update, delete) for each model later.
  // E.g., Future<int> insertTransaction(Transaction transaction) { ... }
  // E.g., Future<List<Transaction>> getTransactions() { ... }
}
