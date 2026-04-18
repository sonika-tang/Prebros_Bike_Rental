import 'package:bike_rental/models/user.dart';
import 'package:bike_rental/data/dtos/pass_dto.dart';

class UserDto {
  static const String idKey = 'userId';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String activePassKey = 'activePass';

  static User fromJson(String id, Map<String, dynamic> json) {
    return User(
      userId: id,
      name: json[nameKey] ?? '',
      email: json[emailKey] ?? '',
      activePass: json[activePassKey] != null
          ? PassDto.fromJson(json[activePassKey]['passId'], json[activePassKey])
          : null,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      idKey: user.userId,
      nameKey: user.name,
      emailKey: user.email,
      activePassKey: user.activePass != null
          ? PassDto.toJson(user.activePass!)
          : null,
    };
  }
}
