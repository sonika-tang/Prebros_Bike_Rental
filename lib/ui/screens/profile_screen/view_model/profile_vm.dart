import 'package:flutter/material.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../models/user.dart';
import '../../../utils/async_value.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  AsyncValue<User> userValue = AsyncValue.loading();

  UserViewModel({required this.userRepository}) {
    _init();
  }

  void _init() async {
    fetchUser("user_001"); 
  }

  Future<void> fetchUser(String userId) async {
    userValue = AsyncValue.loading();
    notifyListeners();

    try {
      final user = await userRepository.getUserById(userId);
      userValue = AsyncValue.success(user);
    } catch (e) {
      userValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    try {
      await userRepository.updateUser(user);
      userValue = AsyncValue.success(user);
    } catch (e) {
      userValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
