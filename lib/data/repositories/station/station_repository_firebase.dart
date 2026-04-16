import 'dart:convert';
import 'package:bike_rental/data/dtos/station_dto.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StationRepositoryFirebase implements StationRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri stationUrl = baseUri.replace(path: '/stations.json');

  @override
  Future<List<Station>> getAllStations() async {
    try {
      final response = await http.get(stationUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Station> stations = [];
        data.forEach((key, value) {
          stations.add(StationDto.fromJson(key, value));
        });
        return stations;
      } else {
        throw Exception('Failed to load stations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load stations: $e');
    }
  }

  @override
  Future<Station?> getStationById(String id) async {
    final specificStationUrl = baseUri.replace(path: '/stations/$id.json');
    final response = await http.get(specificStationUrl);
    if (response.statusCode == 200 && response.body != 'null') {
      final data = json.decode(response.body);
      return StationDto.fromJson(id, data);
    }
    return null;
  }
}
