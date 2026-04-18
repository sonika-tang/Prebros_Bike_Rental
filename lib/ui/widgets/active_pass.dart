import 'package:bike_rental/models/pass.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:flutter/material.dart';

class ActivePass extends StatelessWidget {
  const ActivePass({
    super.key,
    required this.activePass,
    required this.activePassState,
  });

  final Pass? activePass;
  final GlobalPassState activePassState;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    "${activePass?.typeName}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  Text(
                    " Active",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            DetailRow(
              label: "Start Date:",
              value: activePassState.formatDate(activePass?.startDate),
            ),
            const SizedBox(height: 8),
            DetailRow(
              label: "End Date:",
              value: activePassState.formatDate(activePass?.endDate),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
