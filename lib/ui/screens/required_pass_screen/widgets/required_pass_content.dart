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
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Plan Required",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 48),
        
            /// 🚲 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pedal_bike, size: 80, color: Colors.black),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ready to ride now?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "The bike require an active plan.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        
            const SizedBox(height: 60),
        
            Text(
              "Choose Your Plan",
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        
            const SizedBox(height: 24),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: passes.where((p) => p.type != PassType.single).length,
                itemBuilder: (context, index) {
                  final filteredPasses = passes.where((p) => p.type != PassType.single).toList();
                  final pass = filteredPasses[index];
        
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
                              booking: booking,
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pass.typeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.arrow_forward, size: 20, color: colorScheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
