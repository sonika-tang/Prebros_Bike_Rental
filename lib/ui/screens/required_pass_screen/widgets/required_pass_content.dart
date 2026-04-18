import 'package:bike_rental/models/booking.dart';
import 'package:bike_rental/ui/screens/details_screen/details_plan_screen.dart';
import 'package:bike_rental/ui/screens/pass_selection_screen/view_model/pass_selection_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/pass.dart';
import '../../../utils/async_value.dart';

class RequiredPassContent extends StatelessWidget {
  final Booking? booking;
  const RequiredPassContent({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassSelectionViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final asyncValue = vm.passesValue;

    if (asyncValue.state == AsyncValueState.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (asyncValue.state == AsyncValueState.error) {
      return const Scaffold(body: Center(child: Text("Error loading passes")));
    }

    final passes = asyncValue.data!;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Plan Required",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          const SizedBox(height: 24),

          /// 🚲 HEADER
          Column(
            children: [
              const Icon(Icons.pedal_bike, size: 60),
              const SizedBox(height: 10),
              Text(
                "Ready to ride now?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "The bike require an active plan.",
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Text(
            "Choose Your Plan",
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: passes.length,
              itemBuilder: (context, index) {
                final pass = passes[index];

                return _buildPlanItem(
                  context,
                  pass: pass,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: vm,
                          child: PlanDetailsScreen(
                            pass: pass,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem(
    BuildContext context, {
    required Pass pass,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pass.typeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.arrow_forward, size: 16, color: colorScheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
