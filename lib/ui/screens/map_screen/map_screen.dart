import 'package:bike_rental/ui/screens/map_screen/view_model/map_vm.dart';
import 'package:bike_rental/ui/screens/map_screen/widgets/map_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapVm>(
      create: (context) => MapVm(
        repository: context.read(),
      )..init(),
      child: const MapContent(),
    );
  }
}
