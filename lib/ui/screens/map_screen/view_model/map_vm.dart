import 'package:bike_rental/models/active_ride.dart';
import 'package:bike_rental/models/station.dart';
import 'package:bike_rental/ui/service/station_bike.dart';
import 'package:bike_rental/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapVm extends ChangeNotifier {
  final StationBikeService _stationBikeService;

  MapVm({required StationBikeService stationBikeService})
      : _stationBikeService = stationBikeService;

  // State
  AsyncValue<List<Station>> _stationsState = AsyncValue.loading();
  LatLng? _currentUserLocation;
  ActiveRide? _activeRide;

  // UI
  bool _isMapView = true;
  String _searchQuery = '';

  // Getters
  AsyncValue<List<Station>> get stationsState => _stationsState;
  LatLng? get currentUserLocation => _currentUserLocation;
  ActiveRide? get activeRide => _activeRide;
  bool get isMapView => _isMapView;

  List<Station> get filteredStations {
    if (_stationsState.state != AsyncValueState.success ||
        _stationsState.data == null) {
      return [];
    }
    final stations = _stationsState.data!;
    if (_searchQuery.isEmpty) return stations;
    return stations
        .where((s) => s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Entry point
  Future<void> init() async {
    await loadStations();
    await determinePosition();
  }

  Future<void> loadStations() async {
    _stationsState = AsyncValue.loading();
    notifyListeners();
    try {
      final stations = await _stationBikeService.getStationsWithBikes();
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
      final position = await Geolocator.getCurrentPosition();
      _currentUserLocation = LatLng(position.latitude, position.longitude);
      _updateDistance();
      notifyListeners();
    }
  }

  void _updateDistance() {
    if (_currentUserLocation == null ||
        _stationsState.state != AsyncValueState.success ||
        _stationsState.data == null) return;

    final stations = _stationsState.data!;
    for (final s in stations) {
      s.distanceFromUserInMeters = Geolocator.distanceBetween(
        _currentUserLocation!.latitude,
        _currentUserLocation!.longitude,
        s.latitude,
        s.longitude,
      );
    }
    stations.sort(
      (a, b) => (a.distanceFromUserInMeters ?? 0)
          .compareTo(b.distanceFromUserInMeters ?? 0),
    );
  }

  void setActiveRide(ActiveRide ride) {
    _activeRide = ride;
    notifyListeners();
  }

  void returnBike() {
    _activeRide = null;
    notifyListeners();
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