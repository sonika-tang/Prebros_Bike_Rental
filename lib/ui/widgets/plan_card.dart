import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../../../models/pass.dart';

class PlanCard extends StatelessWidget {
  final Pass pass;
  final bool isActive;
  final VoidCallback onSelect; 
  const PlanCard({
    super.key,
    required this.pass,
    required this.isActive,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onSelect, 
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Price",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${pass.price}",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: colorScheme.primary),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      pass.typeName,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _validityText(pass.type),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: isActive ? "Active" : "Select",
                      isActive: isActive,
                      onPressed: isActive ? null : onSelect,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validityText(PassType type) {
    switch (type) {
      case PassType.day:
        return "Valid for 1 day";
      case PassType.weekly:
        return "Valid for 1 week";
      case PassType.monthly:
        return "Valid for 1 month";
      case PassType.annual:
        return "Valid for 1 year";
    }
  }
}
