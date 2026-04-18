import 'package:bike_rental/models/station.dart';

abstract class StationRepository {
  // Fetch all the station to show on the map
  Future<List<Station>> getAllStations();

  // Fetch specific station base on id
  Future<Station?> getStationById(String id);
}
