import 'dart:convert';
import 'package:bike_rental/data/dtos/user_dto.dart';
import 'package:bike_rental/data/repositories/user/user_repository.dart';
import 'package:bike_rental/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserRepositoryFirebase implements UserRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  @override
  Future<User> getUserById(String id) async {
    try {
      final userUrl = baseUri.replace(path: '/users/$id.json');
      final response = await http.get(userUrl);

      if (response.statusCode == 200) {
        if (response.body == 'null') {
          throw Exception('User $id not found');
        }
        final Map<String, dynamic> data = json.decode(response.body);
        return UserDto.fromJson(id, data);
      } else {
        throw Exception(
          'Failed to load user: ${response.statusCode}, body=${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      final userUrl = baseUri.replace(path: '/users/${user.userId}.json');
      final response = await http.put(
        userUrl,
        body: json.encode(UserDto.toJson(user)),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
