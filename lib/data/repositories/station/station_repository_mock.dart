import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';

class StationRepositoryMock implements StationRepository{
  @override
  Future<List<Station>> getAllStations() async{
    return [
      Station(
        stationId: 'station_pp_01',
        name: 'Wat Phnom Station',
        latitude: 11.576089,
        longitude: 104.923055,
        bikes: [],
      ),
      Station(
        stationId: 'station_pp_02',
        name: 'Royal Palace Station',
        latitude: 11.5645, // Example coordinates
        longitude: 104.9312,
        bikes: [],
      ),
    ];
  }

  @override
  Future<Station> getStationById(String id) async{
    final stations = await getAllStations();
    try{
      return stations.firstWhere((station) => station.stationId == id);
    }catch(e){
      throw Exception('Station not found: $id');
    }
  }

}