import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String title; // "Salary", "Groceries", "Rent"
  final String category; // "Monthly", "Pantry", "Rent"
  final DateTime dateTime; // combines time + date shown as "18:27 - April 30"
  final double amount; // positive = income, negative = expense
  final IconData icon; // avatar glyph
  final Color iconBackgroundColor; // the colored circle behind the icon

  const Transaction({
    required this.title,
    required this.category,
    required this.dateTime,
    required this.amount,
    required this.icon,
    required this.iconBackgroundColor,
  });

  bool get isExpense => amount < 0;

  /// e.g. "18:27 - April 30"
  String get formattedDateTime {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '$hour:$minute - ${months[dateTime.month - 1]} ${dateTime.day}';
  }

  /// e.g. "$4.000,00" or "-$100,00"
  String get formattedAmount {
    final sign = amount < 0 ? '-' : '';
    final value = amount.abs().toStringAsFixed(2).replaceAll('.', ',');
    return '$sign\$$value';
  }
}
