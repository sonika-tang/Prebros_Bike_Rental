import 'dart:convert';
import 'package:bike_rental/data/dtos/bike_dto.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BikeRepositoryFirebase implements BikeRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri bikeUrl = baseUri.replace(path: '/bikes.json');

  @override
  Future<List<Bike>> fetchAllBikes() async {
    try {
      final response = await http.get(bikeUrl);
      if (response.statusCode == 200 && response.body != 'null') {
        final data = json.decode(response.body);
        if (data is Map) {
          return data.entries
              .map((e) => BikeDto.fromJson(e.key, e.value))
              .toList();
        } else if (data is Iterable) {
          return data
              .where((b) => b != null)
              .map((b) => BikeDto.fromJson('', b))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load bikes: $e');
    }
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    try {
      final url = Uri.parse('https://$baseUri/bikes/$id.json');
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body != 'null') {
        final data = json.decode(response.body);
        return BikeDto.fromJson(id, data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load bike $id: $e');
    }
  }

  @override
  Future<List<Bike>> fetchBikesByStation(String stationId) async {
    try {
      final url = Uri.parse('https://$baseUri/bikes.json').replace(
        queryParameters: {'orderBy': '"stationId"', 'equalTo': '"$stationId"'},
      );
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body != 'null') {
        final data = json.decode(response.body);
        if (data is Map) {
          return data.entries
              .map((e) => BikeDto.fromJson(e.key, e.value))
              .toList();
        } else if (data is Iterable) {
          return data
              .where((b) => b != null)
              .map((b) => BikeDto.fromJson('', b))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load bikes for station $stationId: $e');
    }
  }
}
