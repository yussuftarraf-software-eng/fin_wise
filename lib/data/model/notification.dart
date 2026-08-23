import 'package:flutter/material.dart';

enum NotificationType { reminder, update, transaction, expense }

extension NotificationTypeIcon on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.reminder:
        return Icons.notifications_none;
      case NotificationType.update:
        return Icons.star_border;
      case NotificationType.transaction:
        return Icons.attach_money;
      case NotificationType.expense:
        return Icons.south_east;
    }
  }
}

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final DateTime dateTime;

  // Only relevant for NotificationType.transaction / .expense entries
  // (e.g. ["Groceries", "Pantry"]). Empty for reminders/updates.
  final List<String> tags;

  // Only relevant for NotificationType.transaction entries (e.g. -100.00).
  // Null for everything else.
  final double? amount;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.dateTime,
    this.tags = const [],
    this.amount,
  });

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// e.g. "17:00 - April 24"
  String get formattedDateTime {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final month = _months[dateTime.month - 1];
    return '$hour:$minute - $month ${dateTime.day}';
  }

  /// e.g. "Groceries | Pantry | -100,00" — empty if there are no tags.
  String get formattedTags {
    if (tags.isEmpty) return '';
    final tagsPart = tags.join(' | ');
    if (amount == null) return tagsPart;
    final amountStr = amount!.toStringAsFixed(2).replaceAll('.', ',');
    return '$tagsPart | $amountStr';
  }
}

/// Groups a notification's dateTime into the section header the UI shows
/// ("Today" / "Yesterday" / "This Weekend" / a plain date otherwise).
String notificationDateGroup(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
  final difference = today.difference(date).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Yesterday';
  if (difference > 1 && difference <= 7) return 'This Weekend';
  return '${date.day}/${date.month}/${date.year}';
}

final List<NotificationModel> mockNotifications = [
  NotificationModel(
    id: '1',
    type: NotificationType.reminder,
    title: 'Reminder!',
    description: 'Set up your automatic savings to meet your savings goal...',
    dateTime: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      17,
      0,
    ),
  ),
  NotificationModel(
    id: '2',
    type: NotificationType.update,
    title: 'New Update',
    description: 'Set up your automatic savings to meet your savings goal...',
    dateTime: DateTime(2025, 4, 24, 17, 0),
  ),
  NotificationModel(
    id: '3',
    type: NotificationType.transaction,
    title: 'Transactions',
    description: 'A new transaction has been registered',
    dateTime: DateTime.now().subtract(const Duration(days: 1)),
    tags: const ['Groceries', 'Pantry'],
    amount: -100.00,
  ),
  NotificationModel(
    id: '4',
    type: NotificationType.reminder,
    title: 'Reminder!',
    description: 'Set up your automatic savings to meet your savings goal...',
    dateTime: DateTime.now().subtract(const Duration(days: 1)),
  ),
  NotificationModel(
    id: '5',
    type: NotificationType.expense,
    title: 'Expense Record',
    description: 'We recommend that you be more attentive to your finances.',
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
  ),
  NotificationModel(
    id: '6',
    type: NotificationType.transaction,
    title: 'Transactions',
    description: 'A new transaction has been registered',
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    tags: const ['Food', 'Dinner'],
    amount: -70.40,
  ),
];
