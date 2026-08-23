import 'package:flutter/material.dart';

class ValidationFunctions {
  // Private constructor — this class is only ever used via its static
  // methods, so there's no reason anyone should be able to do
  // ValidationFunctions() and create an instance of it.
  ValidationFunctions._();

  /// Use as: validator: ValidationFunctions.validateEmail
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'please enter a valid email';
    }
    return null;
  }

  /// Use as: validator: ValidationFunctions.validatePassword
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your password';
    }
    if (value.length < 9) {
      return 'please enter a valid password of at least 9 characters';
    }
    return null;
  }

  /// Expects dd/mm/yyyy. Use as: validator: ValidationFunctions.validateDateOfBirth
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your date of birth';
    }

    final dateRegex = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
    final match = dateRegex.firstMatch(value);
    if (match == null) {
      return 'please enter a valid date (dd/mm/yyyy)';
    }

    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);

    DateTime date;
    try {
      date = DateTime(year, month, day);
    } catch (_) {
      return 'please enter a valid date';
    }
    // DateTime silently rolls over invalid days (e.g. 31/02 -> March 3rd),
    // so check it actually round-trips to the same day/month.
    if (date.day != day || date.month != month || date.year != year) {
      return 'please enter a valid date';
    }

    final now = DateTime.now();
    if (date.isAfter(now)) {
      return 'date of birth cannot be in the future';
    }

    var age = now.year - date.year;
    final birthdayHasNotHappenedYetThisYear =
        now.month < date.month ||
        (now.month == date.month && now.day < date.day);
    if (birthdayHasNotHappenedYetThisYear) {
      age--;
    }
    if (age < 18) {
      return 'you must be at least 18 years old';
    }
    if (age > 120) {
      return 'please enter a valid date of birth';
    }

    return null;
  }

  /// Expects Egyptian mobile numbers: 01[0/1/2/5]xxxxxxxx (11 digits).
  /// Use as: validator: ValidationFunctions.validateMobileNumber
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your mobile number';
    }
    final mobileRegex = RegExp(r'^01[0125]\d{8}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'please enter a valid mobile number';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'please enter your full name';
    }

    // Collapse repeated spaces and trim, so "John   Smith" or
    // "  John Smith  " don't count as extra/missing names.
    final names = value.trim().split(RegExp(r'\s+'));

    if (names.length < 2) {
      return 'please enter at least two names';
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    final hasInvalidName = names.any((name) => !nameRegex.hasMatch(name));
    if (hasInvalidName) {
      return 'names should only contain letters';
    }

    return null;
  }
}
