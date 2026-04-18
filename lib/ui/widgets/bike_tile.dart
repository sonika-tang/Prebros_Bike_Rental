import 'package:flutter/material.dart';
import 'package:bike_rental/models/bike.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;
  final int index;
  final VoidCallback? onTap;

  const BikeTile({
    super.key,
    required this.bike,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = bike.status == BikeStatus.available;
    final statusColor = isAvailable
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.primary;
    final statusText = isAvailable ? "Available" : "Pending";

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              "${index + 1}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 16),
            const Icon(Icons.pedal_bike, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                bike.bikeId,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              statusText,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: statusColor),
            ),
          ],
        ),
      ),
    );
  }
}
