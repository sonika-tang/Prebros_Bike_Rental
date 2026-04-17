import 'package:bike_rental/models/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> fetchAllBikes();
  Future<List<Bike>> fetchBikesByStation(String stationId);
  Future<Bike?> fetchBikeById(String id);
}
