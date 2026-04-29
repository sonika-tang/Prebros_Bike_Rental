import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/ui/screens/map_screen/view_model/map_vm.dart';
import 'package:bike_rental/ui/screens/map_screen/widgets/map_content.dart';
import 'package:bike_rental/ui/service/station_bike.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapVm>(
      create: (context) => MapVm(
        stationBikeService: StationBikeService(
          stationRepository: context.read<StationRepository>(),
          bikeRepository: context.read<BikeRepository>(),
        ),
      )..init(),
      child: const MapContent(),
    );
  }
}