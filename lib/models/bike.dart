class Bike {
  final String bikeId;
  final String stationId;
  final BikeStatus status;

  const Bike({
    required this.bikeId,
    required this.stationId,
    required this.status,
  });

  Bike copyWith({
    String? bikeId,
    String? stationId,
    BikeStatus? status,
  }) {
    return Bike(
      bikeId: bikeId ?? this.bikeId,
      stationId: stationId ?? this.stationId,
      status: status ?? this.status,
    );
  }

  Object? toJson() {
    return {
      'bikeId': bikeId,
      'stationId': stationId,
      'status': status.name,
    };
  }
}

enum BikeStatus { available, booked, pending }
