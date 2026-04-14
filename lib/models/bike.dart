class Bike {
  final String bikeId;
  final String stationId;
  final BikeStatus status;

  const Bike({
    required this.bikeId,
    required this.stationId,
    required this.status,
  });
}

enum BikeStatus { available, booked, pending }
