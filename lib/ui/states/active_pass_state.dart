import 'package:bike_rental/models/pass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class GlobalPassState extends ChangeNotifier {
  Pass? _activePass;

  Pass? get activePass => _activePass;

  /// Set the active pass (after purchase or retrieval from backend)
  void setActivePass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  /// Clear the active pass (after expiration or logout)
  void clearActivePass() {
    _activePass = null;
    notifyListeners();
  }

   String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat("dd/MM/yyyy hh:mm a").format(date);
  }

  String get activePassDurationText {
    if (activePass == null) return "No active pass";
    final start = formatDate(activePass!.startDate);
    final end = formatDate(activePass!.endDate);
    return "Start: $start\nEnd: $end";
  }

  /// Toggle app theme between light and dark
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
