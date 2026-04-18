import 'package:bike_rental/models/booking.dart';
import 'package:bike_rental/ui/screens/confirmation_details_screen/confirmation_details_screen.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/ui/widgets/active_pass.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/pass.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Pass pass;
  final Booking? booking;

  const PaymentSuccessScreen({super.key, required this.pass, this.booking});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activePassState = context.watch<GlobalPassState>();
    final activePass = activePassState.activePass;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Success",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: colorScheme.secondary,
                  size: 100,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Payment Successful!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "You have successfully purchased the ${pass.typeName}.",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (activePass != null)
                ActivePass(activePass: activePass, activePassState: activePassState),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: PrimaryButton(
          label: "Continue",
          onPressed: () {
            if (booking != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmationDetailsScreen(booking: booking!),
                ),
              );
            } else {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
        ),
      ),
    );
  }
}

