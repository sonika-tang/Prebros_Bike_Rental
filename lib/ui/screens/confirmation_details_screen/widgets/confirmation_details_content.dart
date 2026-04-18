import 'package:bike_rental/ui/screens/confirmation_details_screen/view_model/confirmation_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';

class ConfirmationDetailsContent extends StatelessWidget {
  const ConfirmationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConfirmationDetailsVm>();
    final booking = vm.currentBooking;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                /// BIKE ICON & ID
                const Icon(Icons.pedal_bike, size: 80, color: Colors.black),
                const SizedBox(height: 8),
                Text(
                  booking.bikeId,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 32),

                /// ⏱TIMER TEXT
                Text(
                  vm.remainingSeconds > 0
                      ? "Pick up within ${vm.remainingSeconds} seconds"
                      : "Unlock expired",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                /// DETAILS CARD
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow("Station", booking.stationName),
                      const Divider(height: 32),
                      _buildDetailRow("Bike ID", booking.bikeId),
                      const Divider(height: 32),
                      _buildDetailRow("Slot", "1"),
                      const Divider(height: 32),
                      _buildDetailRow("Pass", "1-Day"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// UNLOCK BUTTON (PICKUP SIMULATION)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: "Unlock bike",
              onPressed: () => vm.pickupBike(context),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// CANCEL BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: vm.cancelBooking,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                "Cancel booking",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
