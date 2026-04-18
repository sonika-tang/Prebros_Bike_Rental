import 'package:bike_rental/ui/screens/bike_details_screen/view_model/bike_details_vm.dart';
import 'package:bike_rental/ui/screens/bike_details_screen/widgets/bike_details_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/pass.dart';

class BikeDetailScreen extends StatelessWidget {
  final Bike bike;
  final Pass? activePass;

  const BikeDetailScreen({
    super.key,
    required this.bike,
    required this.activePass,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BikeDetailVm>(
      create: (_) => BikeDetailVm(bike: bike, activePass: activePass),
      child: const BikeDetailContent(),
    );
  }
}
