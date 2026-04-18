import 'package:bike_rental/ui/screens/map_screen/view_model/map_vm.dart';
import 'package:bike_rental/ui/screens/booking_screen/station_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationListView extends StatelessWidget {
  const StationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapVm>();
    final stations = vm.filteredStations;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 90, bottom: 90), // Padding for search bar and active ride bar
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return GestureDetector(
          onTap: () {
            final mapVm = context.read<MapVm>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: mapVm,
                  child: StationDetailScreen(station: station),
                ),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'station_name_${station.stationId}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            station.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.pedal_bike, size: 16, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                          const SizedBox(width: 4),
                          Text(
                            '${station.availableBikesCount}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  station.formatedDistance,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
