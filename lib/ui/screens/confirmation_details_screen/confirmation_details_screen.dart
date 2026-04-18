import 'package:bike_rental/ui/screens/confirmation_details_screen/view_model/confirmation_details_vm.dart';
import 'package:bike_rental/ui/screens/confirmation_details_screen/widgets/confirmation_details_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/models/booking.dart';
import 'package:bike_rental/data/repositories/bike/bike_repository.dart';

class ConfirmationDetailsScreen extends StatelessWidget {
  final Booking booking;

  const ConfirmationDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmationDetailsVm(
        booking: booking,
        bikeRepository: context.read<BikeRepository>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Bike Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const ConfirmationDetailsContent(),
      ),
    );
  }
}
