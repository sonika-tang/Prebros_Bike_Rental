import 'package:bike_rental/ui/screens/pass_selection_screen/view_model/pass_selection_vm.dart';
import 'package:bike_rental/ui/screens/payment_screen/payment_screen.dart';
import 'package:bike_rental/ui/widgets/plan_details_card.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/pass.dart';

class PlanDetailsScreen extends StatelessWidget {
  final Pass pass;

  const PlanDetailsScreen({super.key, required this.pass});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PassSelectionViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Choose Your Plan",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select Plan",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center, 
                ),
                const SizedBox(height: 8),
                Text(
                  "You have selected ${pass.typeName}",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center, 
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Plan Details",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            PlanDetailsCard(pass: pass),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: "Pay \$${pass.price.toStringAsFixed(2)}",
          onPressed: () async {
            await vm.purchasePass(pass, "user_001");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentSuccessScreen(pass: pass),
              ),
            );
          },
        ),
      ),
    );
  }
}
