import 'package:flutter/material.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/station.dart';

class StationDetailsVm extends ChangeNotifier {
  final BikeRepository bikeRepository;
  final Station station;

  StationDetailsVm({required this.bikeRepository, required this.station});

  List<Bike> _bikes = [];
  bool _loading = false;
  String? _error;

  List<Bike> get bikes => _bikes;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> init() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _bikes = await bikeRepository.fetchBikesByStation(station.stationId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
