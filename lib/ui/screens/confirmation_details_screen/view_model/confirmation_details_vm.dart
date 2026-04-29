import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bike_rental/models/active_ride.dart';
import 'package:bike_rental/models/booking.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:provider/provider.dart';

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
    final diff = booking.unlockValidUntil.difference(DateTime.now()).inSeconds;
    remainingSeconds = diff > 0 ? diff : 0;
    notifyListeners();
    if (remainingSeconds == 0) _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void cancelBooking() {
    debugPrint("Cancel booking: ${booking.bookingId}");
  }

  void pickupBike(BuildContext context) {
    debugPrint("Picking up bike: ${booking.bikeId}");

    context.read<GlobalPassState>().setActiveRide(
          ActiveRide(
            bikeId: booking.bikeId,
            stationName: booking.stationName,
            slot: '1',
          ),
        );

    _bikeRepository.updateBikeStatus(booking.bikeId, BikeStatus.booked);

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}