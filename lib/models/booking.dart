class Booking {
  final String bookingId;
  final String bikeId;
  final String userId;
  final String stationName;
  final DateTime bookingTime;
  final BookingStatus status;

  const Booking({
    required this.bookingId,
    required this.bikeId,
    required this.userId,
    required this.bookingTime,
    required this.status,
    required this.stationName,
  });

  // Calculate unlock valid time
  DateTime get unlockValidUntil {
    return bookingTime.add(const Duration(seconds: 30));  // User have 30 seconds to unlock the bike
  }

  bool get isUnlockExpired {
    return DateTime.now().isAfter(unlockValidUntil);
  }
}

enum BookingStatus { pending, confirmed, timeout }
