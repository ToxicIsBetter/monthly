// lib/data/database_helper.dart
import 'package:sqflite/sqflite.dart'
    hide Transaction; // HIDE sqflite's Transaction
import 'package:path/path.dart';
import 'package:monthly/models/transaction.dart'; // Your custom Transaction model

// Import for desktop FFI, also hiding its Transaction type
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction;

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
    // Get the default databases path for the current platform
    String path = await getDatabasesPath();
    // Join the path with your database file name
    String databasePath = join(path, 'monthly_budget.db');

    // Open the database; if it doesn't exist, onCreate will be called
    return await openDatabase(
      databasePath,
      version: 1, // Database version
      onCreate: _onCreate, // Callback for database creation
    );
  }

  // This method is called only once when the database is first created
  Future<void> _onCreate(Database db, int version) async {
    // Create the 'transactions' table
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

    // Create the 'categories' table
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

    // Create the 'accounts' table
    await db.execute('''
      CREATE TABLE accounts(
        id TEXT PRIMARY KEY,
        name TEXT,
        initialBalance REAL,
        currentBalance REAL
      )
    ''');

    // Insert default categories and accounts here on first creation
    // This will be a later step where we populate the database with some initial data
  }

  // --- TRANSACTION CRUD OPERATIONS ---

  /// Inserts a new transaction into the database.
  /// Returns the number of rows affected (should be 1 on success).
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await database;
    return await db.insert(
      'transactions', // Table name
      transaction.toMap(), // Convert Transaction object to Map
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Replace if an item with same ID exists
    );
  }

  /// Retrieves all transactions from the database, ordered by date descending.
  Future<List<Transaction>> getTransactions() async {
    final db = await database;
    // Query the 'transactions' table, ordering by date from newest to oldest
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    // Convert the List<Map<String, dynamic>> into a List<Transaction>
    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  /// Updates an existing transaction in the database.
  /// Returns the number of rows affected (should be 1 on success).
  Future<int> updateTransaction(Transaction transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?', // Specify which row to update
      whereArgs: [transaction.id], // Arguments for the where clause
    );
  }

  /// Deletes a transaction from the database by its ID.
  /// Returns the number of rows affected (should be 1 on success).
  Future<int> deleteTransaction(String id) async {
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  // --- END TRANSACTION CRUD OPERATIONS ---

  //  Add Category CRUD and Account CRUD here later following the same pattern
}
