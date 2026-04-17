import 'package:bike_rental/data/repositories/user/user_repository.dart';
import 'package:bike_rental/models/user.dart';
import 'package:bike_rental/models/pass.dart';

class UserRepositoryMock implements UserRepository {
  @override
  Future<User> getUserById(String id) async {
    if (id == "user_with_pass") {
      return User(
        userId: id,
        name: "Alice Tester",
        email: "alice@example.com",
        activePass: Pass(
          passId: "cat_weekly",
          type: PassType.weekly,
          price: 5.0,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
          isActive: true,
        ),
      );
    } else {
      return User(
        userId: id,
        name: "Bob Tester",
        email: "bob@example.com",
        activePass: null,
      );
    }
  }

  @override
  Future<void> updateUser(User user) async {
    // Simulate success
    print(
      "Mock update: User ${user.userId} updated with activePass=${user.activePass?.typeName}",
    );
  }
}
