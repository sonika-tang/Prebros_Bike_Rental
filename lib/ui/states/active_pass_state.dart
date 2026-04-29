import 'package:bike_rental/models/active_ride.dart';
import 'package:bike_rental/models/pass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalPassState extends ChangeNotifier {
  Pass? _activePass;
  ActiveRide? _activeRide;

  Pass? get activePass => _activePass;
  ActiveRide? get activeRide => _activeRide;

  bool get hasActivePass => _activePass != null;
  bool get hasActiveRide => _activeRide != null;

  void setActivePass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  void setActiveRide(ActiveRide ride) {
    _activeRide = ride;
    notifyListeners();
  }

  void clearActiveRide() {
    _activeRide = null;
    notifyListeners();
  }

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