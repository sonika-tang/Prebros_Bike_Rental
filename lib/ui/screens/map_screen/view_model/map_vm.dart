import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart'; // Coordinates library
import 'package:geolocator/geolocator.dart';

class MapVm extends ChangeNotifier {
  final StationRepository _repository;

  MapVm({required StationRepository repository}) : _repository = repository;

  // State Properties
  List<Station> _stations = [];
  bool _isLoading = false;
  LatLng? _currentUserLocation;
  Station? _selectStation;

  // UI States
  bool _isMapView = true;
  String _searchQuery = '';

  // Active Ride Data
  Map<String, dynamic>? _activeRide;

  // Getters
  List<Station> get stations => _stations;
  List<Station> get filteredStations {
    if (_searchQuery.isEmpty) return _stations;
    return _stations
        .where((s) => s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
  bool get isLoading => _isLoading;
  LatLng? get currentUserLocation => _currentUserLocation;
  Station? get selectStation => _selectStation;
  bool get isMapView => _isMapView;
  Map<String, dynamic>? get activeRide => _activeRide;

  void bookBike(String bikeId, String stationName) {
    _activeRide = {
      'bikeId': bikeId,
      'stationName': stationName,
    };
    notifyListeners();
  }

  void returnBike() {
    _activeRide = null;
    notifyListeners();
  }

  // Entry point for the view model
  Future<void> init() async {
    await loadStations();
    await determinePosition();
  }

  Future<void> loadStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _stations = await _repository.getAllStations();
      _updateDistance();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      _currentUserLocation = LatLng(position.latitude, position.longitude);
      _updateDistance();
      notifyListeners();
    }
  }

  void _updateDistance() {
    if (_currentUserLocation == null || _stations.isEmpty) return;
    for (var s in _stations) {
      s.distanceFromUserInMeters = Geolocator.distanceBetween(
        _currentUserLocation!.latitude,
        _currentUserLocation!.longitude,
        s.latitude,
        s.longitude,
      );
    }
    _stations.sort(
      (a, b) => (a.distanceFromUserInMeters ?? 0).compareTo(
        b.distanceFromUserInMeters ?? 0,
      ),
    );
  }

  void toggleView() {
    _isMapView = !_isMapView;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectLocationAsStation(Station station) {
    _selectStation = station;
    notifyListeners();
  }

  void clearSelection() {
    _selectStation = null;
    notifyListeners();
  }
}
