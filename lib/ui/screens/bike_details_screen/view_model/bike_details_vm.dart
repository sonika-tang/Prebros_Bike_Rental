import 'package:flutter/material.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/pass.dart';

class BikeDetailVm extends ChangeNotifier {
  final Bike bike;
  final Pass? activePass;

  BikeDetailVm({required this.bike, required this.activePass});

  Bike get currentBike => bike;
  Pass? get currentPass => activePass;

  bool get hasActivePass => activePass != null;
}
