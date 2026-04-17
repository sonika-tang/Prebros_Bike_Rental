import 'package:flutter/material.dart';
import '../../../../models/pass.dart';

class PlanDetailsCard extends StatelessWidget {
  final Pass pass;

  const PlanDetailsCard({super.key, required this.pass});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orange header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              "${pass.typeName} Pass",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),

          // Body content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow(
                  context,
                  "Price of the plan:",
                  "\$${pass.price} / ${pass.typeName}",
                ),
                _detailRow(context, "Valid for:", _validityText(pass.type)),
                const SizedBox(height: 12),

                Text(
                  "Description:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "• This pass can only be used once",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "• Explore the city wherever you want to go",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                Text("Benefits:", style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  "• Most suitable for tourists to explore the city",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(text: "$label "),
            TextSpan(
              text: value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _validityText(PassType type) {
    switch (type) {
      case PassType.day:
        return "24 hours";
      case PassType.weekly:
        return "7 days";
      case PassType.monthly:
        return "30 days";
      case PassType.annual:
        return "365 days";
    }
  }
}
