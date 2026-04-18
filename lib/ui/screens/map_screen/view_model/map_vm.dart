import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:bike_rental/models/station.dart';
import 'package:bike_rental/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapVm extends ChangeNotifier {
  final StationRepository _repository;

  MapVm({required StationRepository repository}) : _repository = repository;

  // State Properties
  AsyncValue<List<Station>> _stationsState = AsyncValue.loading();
  LatLng? _currentUserLocation;
  Station? _selectStation;

  // UI States
  bool _isMapView = true;
  String _searchQuery = '';

  // Active Ride Data
  Map<String, dynamic>? _activeRide;

  // Getters
  AsyncValue<List<Station>> get stationsState => _stationsState;

  List<Station> get filteredStations {
    if (_stationsState.state != AsyncValueState.success || _stationsState.data == null) {
      return [];
    }
    final stations = _stationsState.data!;

    if (_searchQuery.isEmpty) return stations;
    return stations
        .where((s) => s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
  LatLng? get currentUserLocation => _currentUserLocation;
  Station? get selectStation => _selectStation;
  bool get isMapView => _isMapView;
  Map<String, dynamic>? get activeRide => _activeRide;

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
    _stationsState = AsyncValue.loading();
    notifyListeners();
    try {
      final stations = await _repository.getAllStations();
      _stationsState = AsyncValue.success(stations);
      _updateDistance();
    } catch (e) {
      _stationsState = AsyncValue.error(e);
    } finally {
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
    if (_currentUserLocation == null || _stationsState.state != AsyncValueState.success || _stationsState.data == null) return;
    
    final stations = _stationsState.data!;
    for (var s in stations) {
      s.distanceFromUserInMeters = Geolocator.distanceBetween(
        _currentUserLocation!.latitude,
        _currentUserLocation!.longitude,
        s.latitude,
        s.longitude,
      );
    }
    stations.sort(
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
}
