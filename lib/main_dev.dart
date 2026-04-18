import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository_mock.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/data/repositories/station/station_repository_mock.dart';
import 'package:bike_rental/data/repositories/pass/pass_mock_repository.dart';
import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/data/repositories/user/user_mock_repository.dart';
import 'package:bike_rental/data/repositories/user/user_repository.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/ui/states/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => MockPassRepository()),
    Provider<UserRepository>(create: (_) => UserRepositoryMock()),
    Provider<StationRepository>(create: (_) => StationRepositoryMock()),
    Provider<BikeRepository>(create: (_) => BikeRepositoryMock()),

    // 2 - Inject global states
    ChangeNotifierProvider<GlobalPassState>(create: (_) => GlobalPassState()),
    ChangeNotifierProvider<AppThemeState>(create: (_) => AppThemeState()),
  ];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  mainCommon(devProviders);
}
