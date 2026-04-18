import 'package:bike_rental/models/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String id);
  Future<void> updateUser(User user);
}
