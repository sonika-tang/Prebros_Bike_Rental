import 'package:bike_rental/models/bike.dart';
import 'package:bike_rental/ui/screens/bike_details_screen/widgets/current_pass_card.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/screens/bike_details_screen/view_model/bike_details_vm.dart';
import 'package:bike_rental/ui/screens/required_pass_screen/required_pass_screen.dart';
import 'package:bike_rental/ui/screens/confirmation_details_screen/confirmation_details_screen.dart';
import 'package:bike_rental/ui/screens/pass_selection_screen/view_model/pass_selection_vm.dart';
import 'package:bike_rental/ui/screens/details_screen/details_plan_screen.dart';
import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/models/pass.dart';

class BikeDetailContent extends StatelessWidget {
  const BikeDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeDetailVm>();
    final activePassState = context.watch<GlobalPassState>();
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
                      // const SizedBox(height: 4),
                      // const Text("Slot 1", style: TextStyle(color: Colors.grey)),
                
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildInfoRow("Type", "City Bike"),
                            SizedBox(height: 15),
                            const Divider(),
                            SizedBox(height: 15),
                            _buildInfoRow("Station", "Central Park"),
                            const SizedBox(height: 15),
                            const Divider(),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                              "Status",
                              vm.currentBike.status.name.toUpperCase(),
                              valueColor: vm.currentBike.status == BikeStatus.available
                                  ? Colors.green
                                  : vm.currentBike.status == BikeStatus.pending
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                            const SizedBox(height: 15),
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
                  if (activePassState.hasActiveRide) ...[
                     const Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text(
                         "You already have an active ride. Please return your current bike before booking another one.",
                         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                         textAlign: TextAlign.center,
                       ),
                     ),
                     const SizedBox(height: 12),
                     SizedBox(
                       width: double.infinity,
                       child: PrimaryButton(
                         label: "Back to Map",
                         onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                       ),
                     ),
                  ] else if (vm.currentBike.status != BikeStatus.available) ...[
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         "This bike is currently ${vm.currentBike.status.name.toUpperCase()}. Please select another bike.",
                         style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                         textAlign: TextAlign.center,
                       ),
                     ),
                     const SizedBox(height: 12),
                     SizedBox(
                       width: double.infinity,
                       child: PrimaryButton(
                         label: "Back to Map",
                         onPressed: () => Navigator.pop(context),
                       ),
                     ),
                  ] else if (vm.hasActivePass) ...[
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: "Unlock bike",
                        onPressed: () {
                          final booking = vm.createBooking();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConfirmationDetailsScreen(booking: booking),
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: "Buy Pass",
                        onPressed: () {
                          final booking = vm.createBooking();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RequiredPassScreen(booking: booking),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          final booking = vm.createBooking();
                          // For single ticket, we navigate directly to details
                          final singleTicket = Pass(
                            passId: 'cat_single',
                            type: PassType.single,
                            price: 1.0,
                            startDate: null,
                            endDate: null,
                            isActive: false,
                          );
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (context) => PassSelectionViewModel(
                                  repository: context.read<PassRepository>(),
                                  globalPassState: context.read<GlobalPassState>(),
                                ),
                                child: PlanDetailsScreen(
                                  pass: singleTicket,
                                  booking: booking,
                                ),
                              ),
                            ),
                          );
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

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey)),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: valueColor ?? Colors.black,
        ),
      ),
    ],
  );
}
