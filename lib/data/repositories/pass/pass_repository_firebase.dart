import 'dart:convert';
import 'package:bike_rental/data/dtos/pass_dto.dart';
import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/models/pass.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PassRepositoryFirebase implements PassRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri passesUrl = baseUri.replace(path: '/passes_catalog.json');

  @override
  Future<List<Pass>> getAvailablePasses() async {
    try {
      final response = await http.get(passesUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Pass> passes = [];
        data.forEach((key, value) {
          passes.add(PassDto.fromJson(key, value));
        });
        passes.sort((a, b) => a.price.compareTo(b.price));
        return passes;
      } else {
        throw Exception('Failed to load passes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load passes: $e');
    }
  }

  @override
  Future<void> purchasePass(Pass pass, String userId) async {
    final userUrl = baseUri.replace(path: '/users/$userId/activePass.json');
    final response = await http.put(
      userUrl,
      body: json.encode(PassDto.toJson(pass)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to purchase pass: ${response.statusCode}');
    }
  }
}
