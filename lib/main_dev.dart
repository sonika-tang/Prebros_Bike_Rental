import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    // 1 - Inject repositories
    //Provider<PassRepository>(create: (_) => MockPassRepository()),
    //Provider<StationRepository>(create: (_) => MockStationRepository()),
    //Provider<BikeRepository>(create: (_) => MockBikeRepository()),

    // 2 - Inject global states
    ChangeNotifierProvider<GlobalPassState>(create: (_) => GlobalPassState()),
  ];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  mainCommon(devProviders);
}
