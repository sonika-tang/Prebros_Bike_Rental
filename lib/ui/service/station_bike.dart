import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';

/// Responsible for combining stations with their bikes.
class StationBikeService {
  final StationRepository _stationRepository;
  final BikeRepository _bikeRepository;

  StationBikeService({
    required StationRepository stationRepository,
    required BikeRepository bikeRepository,
  })  : _stationRepository = stationRepository,
        _bikeRepository = bikeRepository;

  /// Returns all stations with their bikes populated.
  Future<List<Station>> getStationsWithBikes() async {
    final stations = await _stationRepository.getAllStations();
    final allBikes = await _bikeRepository.fetchAllBikes();

    return stations.map((station) {
      final stationBikes = allBikes
          .where((bike) => bike.stationId == station.stationId)
          .toList();

      return Station(
        stationId: station.stationId,
        name: station.name,
        latitude: station.latitude,
        longitude: station.longitude,
        bikes: stationBikes,
      );
    }).toList();
  }

  /// Returns a single station with its bikes populated.
  Future<Station?> getStationWithBikes(String stationId) async {
    final station = await _stationRepository.getStationById(stationId);
    if (station == null) return null;

    final bikes = await _bikeRepository.fetchBikesByStation(stationId);

    return Station(
      stationId: station.stationId,
      name: station.name,
      latitude: station.latitude,
      longitude: station.longitude,
      bikes: bikes,
    );
  }
}