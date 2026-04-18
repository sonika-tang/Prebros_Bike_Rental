import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository_mock.dart'; // Import your bike mock
import 'package:bike_rental/models/station.dart';

class StationRepositoryMock implements StationRepository {
  // Use the Bike Mock to get data
  final BikeRepository bikeRepo = BikeRepositoryMock();

  @override
  Future<List<Station>> getAllStations() async {
    // 1. Fetch all bikes from the mock repo
    final allBikes = await bikeRepo.fetchAllBikes();

    // 2. Define the stations
    final stationData = [
      {
        'id': 'station_pp_01',
        'name': 'Wat Phnom Station',
        'lat': 11.576089,
        'lng': 104.923055,
      },
      {
        'id': 'station_pp_02',
        'name': 'Royal Palace Station',
        'lat': 11.5645,
        'lng': 104.9312,
      },
      {
        'id': 'station_pp_03',
        'name': 'Independence Monument',
        'lat': 11.5564,
        'lng': 104.9282,
      },
    ];

    // 3. Map stations and filter bikes that belong to each station
    return stationData.map((data) {
      final String id = data['id'] as String;

      return Station(
        stationId: id,
        name: data['name'] as String,
        latitude: data['lat'] as double,
        longitude: data['lng'] as double,
        // Filter the list of all bikes for this specific station ID
        bikes: allBikes.where((bike) => bike.stationId == id).toList(),
      );
    }).toList();
  }

  @override
  Future<Station?> getStationById(String id) async {
    final stations = await getAllStations();
    try {
      return stations.firstWhere((station) => station.stationId == id);
    } catch (e) {
      return null;
    }
  }
}
