import 'package:bike_rental/models/pass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalPassState extends ChangeNotifier {
  Pass? _activePass;
  Map<String, dynamic>? _activeRide;

  Pass? get activePass => _activePass;
  Map<String, dynamic>? get activeRide => _activeRide;

  bool get hasActivePass => _activePass != null;
  bool get hasActiveRide => _activeRide != null;

  /// Set the active pass (after purchase or retrieval from backend)
  void setActivePass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  void setActiveRide(Map<String, dynamic>? ride) {
    _activeRide = ride;
    notifyListeners();
  }

  void clearActiveRide() {
    _activeRide = null;
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
}
