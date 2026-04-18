import 'package:bike_rental/models/pass.dart';
import 'package:flutter/material.dart';

class CurrentPassCard extends StatelessWidget {
  const CurrentPassCard({super.key, required this.activePass});

  final Pass? activePass;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasPass = activePass != null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'CURRENT PASS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          if (hasPass) ...[
            Text(
              'You have active pass',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 16),
            _PassRow(label: 'Type:', value: activePass?.typeName ?? "Unknown"),
            const SizedBox(height: 10),
            _PassRow(
              label: 'Expires:',
              value: _formatDate(activePass?.endDate),
            ),
          ] else ...[
            Text(
              'No active pass',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 6),
            Text(
              "You don't have an active pass",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ]
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _PassRow extends StatelessWidget {
  const _PassRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
