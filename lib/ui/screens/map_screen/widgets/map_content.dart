import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:bike_rental/models/active_ride.dart';
import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/ui/screens/map_screen/view_model/map_vm.dart';
import 'package:bike_rental/ui/screens/map_screen/widgets/station_list_view.dart';
import 'package:bike_rental/ui/screens/station_details_screen/station_detail_screen.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapVm>();
    final activePassState = context.watch<GlobalPassState>();

    // GlobalPassState is the single source of truth for active ride
    final activeRide = activePassState.activeRide ?? vm.activeRide;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (vm.isMapView)
              _buildMap(context, vm)
            else
              const StationListView(),

            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: _buildSearchBar(context, vm),
            ),

            if (activeRide != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildActiveRideBar(context, activeRide),
              ),

            if (vm.stationsState.state == AsyncValueState.loading)
              const Center(child: CircularProgressIndicator())
            else if (vm.stationsState.state == AsyncValueState.error)
              Center(child: Text('Error: ${vm.stationsState.error}')),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, MapVm vm) {
    final markers = vm.filteredStations.map((station) {
      final isAvailable = station.availableBikesCount > 0;
      return Marker(
        point: LatLng(station.latitude, station.longitude),
        width: 60,
        height: 80,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<MapVm>(),
                  child: StationDetailScreen(station: station),
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.26),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${station.availableBikesCount}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Icon(
                Icons.location_on,
                color: isAvailable
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ],
          ),
        ),
      );
    }).toList();

    if (vm.currentUserLocation != null) {
      markers.add(
        Marker(
          point: vm.currentUserLocation!,
          width: 20,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.26),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(11.576089, 104.923055),
        initialZoom: 14,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.bike_rental',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, MapVm vm) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: vm.setSearchQuery,
        decoration: InputDecoration(
          hintText: "Search for station...",
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.54),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              vm.isMapView ? Icons.list : Icons.map,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.54),
            ),
            onPressed: vm.toggleView,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveRideBar(BuildContext context, ActiveRide ride) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Active Ride Details',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text('Bike ID: ${ride.bikeId}'),
                Text('Station: ${ride.stationName}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<MapVm>().returnBike();
                    context.read<GlobalPassState>().clearActiveRide();
                    context
                        .read<BikeRepository>()
                        .updateBikeStatus(ride.bikeId, BikeStatus.available);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Return Bike'),
                ),
              ],
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.pedal_bike,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 40,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bike ID: ${ride.bikeId}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "Station: ${ride.stationName}\nBike slot: ${ride.slot}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withValues(alpha: 0.8),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Active",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}