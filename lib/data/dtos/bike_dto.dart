import 'package:bike_rental/models/bike.dart';

class BikeDto {
  static const String bikeIdKey = 'bikeId';
  static const String stationIdKey = 'stationId';
  static const String statusKey = 'status';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    assert(json[stationIdKey] is String);
    assert(json[statusKey] is String);

    return Bike(
      bikeId: id,
      stationId: json[stationIdKey] as String,
      status: _mapStatus(json[statusKey] as String),
    );
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {
      bikeIdKey: bike.bikeId,
      stationIdKey: bike.stationId,
      statusKey: bike.status.name,
    };
  }

  /// Helper to map string → enum (BikeStatus)
  static BikeStatus _mapStatus(String status) {
    switch (status) {
      case 'available':
        return BikeStatus.available;
      case 'pending':
        return BikeStatus.pending;
      case 'booked':
        return BikeStatus.booked;
      default:
        return BikeStatus.available;
    }
  }
}
