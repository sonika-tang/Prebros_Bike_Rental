import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bike_rental/models/booking.dart';

class ConfirmationDetailsVm extends ChangeNotifier {
  final Booking booking;
  Timer? _timer;
  int remainingSeconds = 0;

  Booking get currentBooking => booking;

  ConfirmationDetailsVm({required this.booking}) {
    _startCountdown();
  }

  void _startCountdown() {
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = booking.unlockValidUntil.difference(now).inSeconds;
    remainingSeconds = diff > 0 ? diff : 0;
    notifyListeners();
    if (remainingSeconds == 0) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void cancelBooking() {
    // Cancel booking logic
    debugPrint("Cancel booking: ${booking.bookingId}");
  }
}
