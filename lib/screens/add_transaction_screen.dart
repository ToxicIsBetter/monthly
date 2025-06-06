// lib/screens/add_transaction_screen.dart
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import 'package:intl/intl.dart'; // For date formatting

import 'package:monthly/models/transaction.dart';
import 'package:monthly/state_management/transaction_notifier.dart';

// A placeholder for category and account IDs for now.
// We'll properly manage these when we implement Categories and Accounts.
const String defaultCategoryId = 'default_category';
const String defaultAccountId = 'default_account';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  // Controllers for text input fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // State variables for dropdowns/selectors
  DateTime _selectedDate = DateTime.now();
  String _transactionType = 'expense'; // 'expense' or 'income'

  // Placeholder values for Category and Account for now
  String _selectedCategory = 'Food'; // Will be a real Category object later
  String _selectedAccount = 'Cash'; // Will be a real Account object later

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000), // Start year for picker
      lastDate: DateTime(2101), // End year for picker
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to save the transaction
  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Triggers onSaved callbacks if any

      final String title = _titleController.text;
      final double amount = double.tryParse(_amountController.text) ?? 0.0;
      final String description = _descriptionController.text;

      // Generate a unique ID for the new transaction
      final String id = const Uuid().v4();

      final newTransaction = Transaction(
        id: id,
        title: title,
        amount: amount,
        date: _selectedDate,
        type: _transactionType,
        categoryId: defaultCategoryId, // Placeholder
        accountId: defaultAccountId, // Placeholder
        description: description.isEmpty ? null : description,
      );

      // Add the transaction using the TransactionNotifier
      Provider.of<TransactionNotifier>(
        context,
        listen: false,
      ).addTransaction(newTransaction);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction saved successfully!')),
      );

      // Navigate back to the previous screen (e.g., Dashboard or Transactions list)
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Transaction'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title (e.g., Groceries, Salary)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ), // Allow numbers and max 2 decimal places
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Amount must be greater than zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Transaction Type (Income/Expense)
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Expense'),
                      value: 'expense',
                      groupValue: _transactionType,
                      onChanged: (value) {
                        setState(() {
                          _transactionType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Income'),
                      value: 'income',
                      groupValue: _transactionType,
                      onChanged: (value) {
                        setState(() {
                          _transactionType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Date Picker
              ListTile(
                title: const Text('Date'),
                subtitle: Text(
                  DateFormat('dd MMMM yyyy').format(_selectedDate),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16.0),

              // Category (Placeholder for now)
              ListTile(
                title: const Text('Category'),
                subtitle: Text(_selectedCategory),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Category selection screen later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category selection (Coming Soon)!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),

              // Account (Placeholder for now)
              ListTile(
                title: const Text('Account'),
                subtitle: Text(_selectedAccount),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Account selection screen later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account selection (Coming Soon)!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  backgroundColor: Theme.of(
                    context,
                  ).floatingActionButtonTheme.backgroundColor,
                  foregroundColor: Theme.of(
                    context,
                  ).floatingActionButtonTheme.foregroundColor,
                ),
                child: const Text('Save Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
