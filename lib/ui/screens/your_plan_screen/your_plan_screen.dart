import 'package:bike_rental/ui/screens/pass_selection_screen/pass_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:bike_rental/ui/widgets/active_pass.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';

class YourPlanScreen extends StatelessWidget {
  const YourPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activePassState = context.watch<GlobalPassState>();
    final activePass = activePassState.activePass;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Plan",
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (activePass != null)
              SizedBox(
                width: double.infinity,
                child: ActivePass(
                  activePass: activePass,
                  activePassState: activePassState,
                ),
              ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Highlight of Your Benefit",
                style: textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 12),

            BenefitBox(
              benefits: const [
                "Unlimited access throughout the day",
                "Save money on frequent rides",
                "Convenient for 1 day mobility",
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: "Cancel plan",
          onPressed: () {
            // Clear active pass
            activePassState.clearActivePass();

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Plan cancelled")));

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
              (route) => route.isFirst,
            );
          },
        ),
      ),
    );
  }
}

class BenefitBox extends StatelessWidget {
  final List<String> benefits;

  const BenefitBox({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: benefits
              .map(
                (b) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(b, style: theme.textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
