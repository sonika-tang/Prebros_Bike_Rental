import 'package:bike_rental/ui/screens/bike_details_screen/widgets/current_pass_card.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/screens/bike_details_screen/view_model/bike_details_vm.dart';

class BikeDetailContent extends StatelessWidget {
  const BikeDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeDetailVm>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Bike Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Container(
              width: double.infinity,
              color: colorScheme.primary.withValues(alpha: 0.15),
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pedal_bike, size: 60),
                  const SizedBox(height: 12),
                  Text(
                    vm.currentBike.bikeId,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bike: ${vm.currentBike.bikeId}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text("Slot 1", style: TextStyle(color: Colors.grey)),
                
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildInfoRow("Type", "City Bike"),
                            SizedBox(height: 15),
                            const Divider(),
                            SizedBox(height: 15),
                            _buildInfoRow("Station", "Central Park"),
                            SizedBox(height: 15),
                            const Divider(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                
                      CurrentPassCard(activePass: vm.activePass),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                
              ],
            ),

            const SizedBox(height: 40),

            // CurrentPassCard(activePass: vm.activePass),
            // const SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (vm.hasActivePass) ...[
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: "Unlock bike",
                        onPressed: () {
                          // Unlock bike logic
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: "Buy Pass",
                        onPressed: () {
                          // Navigate to buy pass
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Navigate to buy single ticket
                        },
                        child: const Text("Buy single ticket"),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
    ],
  );
}
