import 'dart:convert';
import 'package:bike_rental/data/dtos/bike_dto.dart';
import 'package:bike_rental/data/dtos/station_dto.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/station.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StationRepositoryFirebase implements StationRepository {
  static final String baseUrl = dotenv.env['FIREBASE_DB_URL'] ?? '';
  static Uri get stationUrl => Uri.parse('https://$baseUrl/stations.json');
  static Uri get bikesUrl => Uri.parse('https://$baseUrl/bikes.json');

  @override
  Future<List<Station>> getAllStations() async {
    try {
      final response = await http.get(stationUrl);
      final bikesResponse = await http.get(bikesUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        List<Bike> allBikes = [];
        if (bikesResponse.statusCode == 200 && bikesResponse.body != 'null') {
          final bikeData = json.decode(bikesResponse.body);
          if (bikeData is Map) {
            allBikes = bikeData.entries
                .map((e) => BikeDto.fromJson(e.key, e.value))
                .toList();
          } else if (bikeData is Iterable) {
            for (var b in bikeData) {
              if (b != null) allBikes.add(BikeDto.fromJson('', b));
            }
          }
        }

        return data.entries.map((e) {
          final stationBikes = allBikes.where((b) => b.stationId == e.key).toList();
          return StationDto.fromJson(e.key, e.value, bikes: stationBikes);
        }).toList();
      } else {
        throw Exception('Failed to load stations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load stations: $e');
    }
  }

  @override
  Future<Station?> getStationById(String id) async {
    final url = Uri.parse('https://$baseUrl/stations/$id.json');
    final response = await http.get(url);
    if (response.statusCode == 200 && response.body != 'null') {
      final data = json.decode(response.body);

      final bikesResponse = await http.get(bikesUrl);
      List<Bike> allBikes = [];
      if (bikesResponse.statusCode == 200 && bikesResponse.body != 'null') {
        final bikeData = json.decode(bikesResponse.body);
        if (bikeData is Map) {
          allBikes = bikeData.entries
              .map((e) => BikeDto.fromJson(e.key, e.value))
              .toList();
        } else if (bikeData is Iterable) {
          for (var b in bikeData) {
            if (b != null) allBikes.add(BikeDto.fromJson('', b));
          }
        }
      }
      
      final stationBikes = allBikes.where((b) => b.stationId == id).toList();

      return StationDto.fromJson(id, data, bikes: stationBikes);
    }
    return null;
  }
}
