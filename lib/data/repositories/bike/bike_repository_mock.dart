import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/models/bike.dart';

class BikeRepositoryMock implements BikeRepository {
  final List<Bike> _bikes = [
    Bike(
      bikeId: 'bike_20251',
      stationId: 'station_pp_01',
      status: BikeStatus.available,
    ),
    Bike(
      bikeId: 'bike_20252',
      stationId: 'station_pp_01',
      status: BikeStatus.pending,
    ),
    Bike(
      bikeId: 'bike_20253',
      stationId: 'station_pp_02',
      status: BikeStatus.booked,
    ),
    Bike(
      bikeId: 'bike_20254',
      stationId: 'station_pp_03',
      status: BikeStatus.available,
    ),
  ];

  @override
  Future<List<Bike>> fetchAllBikes() async {
    return _bikes;
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    try {
      return _bikes.firstWhere((bike) => bike.bikeId == id);
    } catch (e) {
      throw Exception('Bike not found: $id');
    }
  }

  @override
  Future<List<Bike>> fetchBikesByStation(String stationId) async {
    return _bikes.where((bike) => bike.stationId == stationId).toList();
  }

  @override
  Future<void> updateBikeStatus(String id, BikeStatus status) async {
    final index = _bikes.indexWhere((b) => b.bikeId == id);
    if (index != -1) {
      _bikes[index] = _bikes[index].copyWith(status: status);
    }
  }
}
