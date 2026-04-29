import 'dart:convert';
import 'package:bike_rental/data/dtos/pass_dto.dart';
import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/models/pass.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PassRepositoryFirebase implements PassRepository {
  static final String baseUrl = dotenv.env['FIREBASE_DB_URL'] ?? '';
  static Uri get baseUri => Uri.parse('https://$baseUrl');
  static Uri get passesUrl => Uri.parse('https://$baseUrl/passes_catalog.json');

  @override
  Future<List<Pass>> getAvailablePasses() async {
    try {
      final response = await http.get(passesUrl);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        // Firebase returns literal null when the node is empty
        if (decoded == null) return [];
        final Map<String, dynamic> data = decoded as Map<String, dynamic>;
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
    final userUrl = Uri.parse('https://$baseUrl/users/$userId/activePass.json');
    final response = await http.put(
      userUrl,
      body: json.encode(PassDto.toJson(pass)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to purchase pass: ${response.statusCode}');
    }
  }
}
