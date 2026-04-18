import 'package:flutter/material.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/pass.dart';
import 'package:bike_rental/models/booking.dart';

class BikeDetailVm extends ChangeNotifier {
  final Bike bike;
  final Pass? activePass;

  BikeDetailVm({required this.bike, required this.activePass});

  Bike get currentBike => bike;
  Pass? get currentPass => activePass;

  bool get hasActivePass => activePass != null;

  Booking createBooking() {
    return Booking(
      bookingId: 'book_${DateTime.now().millisecondsSinceEpoch}',
      bikeId: bike.bikeId,
      userId: 'user_001',
      bookingTime: DateTime.now(),
      status: BookingStatus.pending,
      stationName: 'Central Park', // Mock station name
    );
  }
}
