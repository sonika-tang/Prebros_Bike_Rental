import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bike_rental/models/booking.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository.dart';

class ConfirmationDetailsVm extends ChangeNotifier {
  final Booking booking;
  final BikeRepository _bikeRepository;
  Timer? _timer;
  int remainingSeconds = 0;

  Booking get currentBooking => booking;

  ConfirmationDetailsVm({
    required this.booking,
    required BikeRepository bikeRepository,
  }) : _bikeRepository = bikeRepository {
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

  void pickupBike(BuildContext context) {
    // Simulate pickup
    debugPrint("Picking up bike: ${booking.bikeId}");
    
    final globalState = context.read<GlobalPassState>();
    globalState.setActiveRide({
      'bikeId': booking.bikeId,
      'stationName': booking.stationName,
      'slot': '1', // Mock slot
    });

    // Update bike status to booked
    _bikeRepository.updateBikeStatus(booking.bikeId, BikeStatus.booked);

    // Navigate back to map (which is the first screen)
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
