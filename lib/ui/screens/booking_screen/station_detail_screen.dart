import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/models/station.dart';
import 'package:bike_rental/ui/screens/map_screen/view_model/map_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Available bike",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'station_name_${station.stationId}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      station.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bike available: ${station.availableBikesCount}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey[300]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: station.bikes.length,
              itemBuilder: (context, index) {
                final bike = station.bikes[index];

                // Set styles depending on status
                final isAvailable = bike.status == BikeStatus.available;
                final statusColor = isAvailable
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary;
                final statusText = isAvailable ? "Available" : "Pending";
                
                // Can change this when implement booking
                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                          final vm = context.read<MapVm>();
                          if (vm.activeRide != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'You already have an active ride!',
                                ),
                              ),
                            );
                            return;
                          }

                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: const Text('Book Bike'),
                              content: Text(
                                'Are you sure you want to book bike ${bike.bikeId}?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    vm.bookBike(bike.bikeId, station.name);
                                    Navigator.pop(
                                      dialogContext,
                                    ); // Close dialog
                                    Navigator.pop(
                                      context,
                                    ); // Navigate back to map
                                  },
                                  child: const Text('Book'),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${index + 1}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.pedal_bike, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            bike.bikeId,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          statusText,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: statusColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
