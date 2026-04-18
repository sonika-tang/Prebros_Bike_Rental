import 'package:bike_rental/ui/screens/station_details_screen/widgets/current_pass_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activePass = context.watch<GlobalPassState>().activePass;
    return Column(
      children: [
        CurrentPassCard(activePass: activePass),
      ],
    );
  }
}