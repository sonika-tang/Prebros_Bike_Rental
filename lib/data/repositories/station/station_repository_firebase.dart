import 'dart:convert';
import 'package:bike_rental/data/dtos/station_dto.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StationRepositoryFirebase implements StationRepository {
  static final String baseUrl = dotenv.env['FIREBASE_DB_URL'] ?? '';
  static Uri get stationUrl => Uri.parse('https://$baseUrl/stations.json');

  @override
  Future<List<Station>> getAllStations() async {
    try {
      final response = await http.get(stationUrl);

      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> data = json.decode(response.body);
        return data.entries
            .map((e) => StationDto.fromJson(e.key, e.value))
            .toList();
      } else {
        throw Exception('Failed to load stations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load stations: $e');
    }
  }

  @override
  Future<Station?> getStationById(String id) async {
    try {
      final url = Uri.parse('https://$baseUrl/stations/$id.json');
      final response = await http.get(url);

      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> data = json.decode(response.body);
        return StationDto.fromJson(id, data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load station $id: $e');
    }
  }
}