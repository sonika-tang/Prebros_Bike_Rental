import 'package:bike_rental/ui/confirmation_details_screen/view_model/confirmation_details_vm.dart';
import 'package:bike_rental/ui/confirmation_details_screen/widgets/confirmation_details_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/models/booking.dart';

class ConfirmationDetailsScreen extends StatelessWidget {
  final Booking booking;

  const ConfirmationDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmationDetailsVm(booking: booking),
      child: const ConfirmationDetailsContent(),
    );
  }
}
