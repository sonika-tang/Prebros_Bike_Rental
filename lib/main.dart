import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/data/repositories/pass/pass_repository_firebase.dart';
import 'package:bike_rental/data/repositories/user/user_repository.dart';
import 'package:bike_rental/data/repositories/user/user_repository_firebase.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for production environment
List<InheritedProvider> get prodProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => PassRepositoryFirebase()),
    Provider<UserRepository>(create: (_) => UserRepositoryFirebase()),
    //Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),
    //Provider<BikeRepository>(create: (_) => BikeRepositoryFirebase()),

    // 2 - Inject global states
    ChangeNotifierProvider<GlobalPassState>(create: (_) => GlobalPassState()),
  ];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  mainCommon(prodProviders);
}
