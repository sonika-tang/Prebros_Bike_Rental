import 'package:bike_rental/ui/confirmation_details_screen/view_model/confirmation_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';

class ConfirmationDetailsContent extends StatelessWidget {
  const ConfirmationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConfirmationDetailsVm>();
    final booking = vm.currentBooking;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.pedal_bike, size: 60, color: Colors.black),
          const SizedBox(height: 12),
          Text(
            booking.bikeId,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            vm.remainingSeconds > 0
                ? "Pick up within ${vm.remainingSeconds} seconds"
                : "Unlock expired",
            style: const TextStyle(color: Colors.black54),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: "Cancel booking",
              onPressed: vm.cancelBooking,
            ),
          ),
        ],
      ),
    );
  }
}
