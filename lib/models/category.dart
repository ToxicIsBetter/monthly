// lib/models/category.dart
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon; // Storing icon data (requires FontAwesomeIcons)
  final Color color; // For visual distinction

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint, // Store icon as integer code point
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
      'colorValue': color.toARGB32(), // Store color as integer value
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      icon: IconData(
        map['iconCodePoint'],
        fontFamily: map['iconFontFamily'],
        fontPackage: map['iconFontPackage'],
      ),
      color: Color(map['colorValue']),
    );
  }
}
