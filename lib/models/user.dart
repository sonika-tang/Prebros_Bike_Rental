import 'package:bike_rental/models/pass.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final Pass? activePass;   // Nullable because some user might not have pass

  const User({
    required this.userId,
    required this.name,
    required this.email,
    this.activePass,
  });

  // UI helper: context.read<ProfileViewModel>().user.hasActivePass
  bool get hasActivePass => activePass != null && activePass!.isActive;
}
