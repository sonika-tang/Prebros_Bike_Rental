import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/models/station.dart';
import 'view_model/station_details_vm.dart';
import 'widgets/station_details_content.dart';

class StationDetailScreen extends StatelessWidget {
  final Station station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationDetailsVm>(
      create: (context) =>
          StationDetailsVm(bikeRepository: context.read(), station: station)
            ..init(),
      child: StationDetailsContent(),
    );
  }
}
