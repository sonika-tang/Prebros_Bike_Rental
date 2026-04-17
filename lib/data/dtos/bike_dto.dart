import 'package:bike_rental/models/bike.dart';

class BikeDto {
  static const String bikeIdKey = 'bikeId';
  static const String stationIdKey = 'stationId';
  static const String statusKey = 'status';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    final statusString = json[statusKey]?.toString() ?? 'available';
    
    return Bike(
      bikeId: json[bikeIdKey]?.toString() ?? id,
      stationId: json[stationIdKey]?.toString() ?? '',
      status: BikeStatus.values.firstWhere(
        (e) => e.name == statusString,
        orElse: () => BikeStatus.pending,
      ),
    );
  }
}
