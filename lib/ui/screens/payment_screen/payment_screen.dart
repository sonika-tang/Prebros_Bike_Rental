import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/ui/widgets/active_pass.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/pass.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Pass pass;

  const PaymentSuccessScreen({super.key, required this.pass});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activePassState = context.watch<GlobalPassState>();
    final activePass = activePassState.activePass;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Your Plan",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(Icons.check, color: Theme.of(context).colorScheme.onSecondary, size: 50),
            ),
            const SizedBox(height: 20),

            Text(
              "Payment Successful!",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "You are subscribed to ${pass.typeName}.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            if (activePass != null)
              SizedBox(
                width: double.infinity, 
                child: ActivePass(activePass: activePass, activePassState: activePassState),
              ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: "Done",
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }
}

