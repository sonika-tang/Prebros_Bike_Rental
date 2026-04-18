import 'package:bike_rental/ui/widgets/bike_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/station_details_vm.dart';

class StationDetailsContent extends StatelessWidget {
  const StationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationDetailsVm>();

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
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
          ? Center(child: Text("Error: ${vm.error}"))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'station_name_${vm.station.stationId}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            vm.station.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Bike available: ${vm.bikes.length}",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: vm.bikes.length,
                    itemBuilder: (context, index) {
                      final bike = vm.bikes[index];
                      return BikeTile(
                        bike: bike, 
                        index: index,
                        onTap: () {
                          
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
