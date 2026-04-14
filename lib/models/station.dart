import 'package:bike_rental/models/bike.dart';

class Station {
  final String stationId;
  final String name;
  final double latitude; // e.g., coordinates in Phnom Penh
  final double longitude;
  final List<Bike> bikes;

  // Transient property (calculated by ViewModel, not saved in Firebase)
  double? distanceFromUserInMeters;

  Station({
    required this.stationId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.bikes,
    this.distanceFromUserInMeters,
  });

  // Count bike that available in the dock
  int get availableBikesCount {
    return bikes.where((bike) => bike.status == BikeStatus.available).length;
  }

  // Formatting the distance text on the list screen
  String get formatedDistance {
    if (distanceFromUserInMeters == null) return "Calculating...";
    if (distanceFromUserInMeters! >= 1000) {
      return "${(distanceFromUserInMeters! / 1000).toStringAsFixed(1)} km";
    }
    return "${distanceFromUserInMeters!.toInt()} m";
  }
}
