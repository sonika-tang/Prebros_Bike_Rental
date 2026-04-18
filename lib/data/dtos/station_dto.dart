import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/station.dart';

class StationDto {
  static const String idKey = 'stationId';
  static const String nameKey = 'name';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String bikesKey = 'bikes';

  static Station fromJson(String id, Map<String, dynamic> json, {List<Bike> bikes = const []}) {
    assert(json[idKey] is String);
    assert(json[nameKey] is String);
    assert(json[latitudeKey] is double);
    assert(json[longitudeKey] is double);

    return Station(
      stationId: id,
      name: json[nameKey],
      latitude: double.parse(json[latitudeKey].toString()),
      longitude: double.parse(json[longitudeKey].toString()),
      bikes: bikes,
    );
  }

  Map<String, dynamic> toJson(Station station) {
    return {
      idKey: station.stationId,
      nameKey: station.name,
      latitudeKey: station.latitude.toString(),
      longitudeKey: station.longitude.toString(),
      bikesKey: station.bikes.map((bike) => bike.toJson()).toList(),
    };
  }
}
