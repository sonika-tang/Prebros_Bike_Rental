import 'package:bike_rental/models/booking.dart';
import 'package:bike_rental/ui/screens/pass_selection_screen/view_model/pass_selection_vm.dart';
import 'package:bike_rental/ui/screens/required_pass_screen/widgets/required_pass_content.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/repositories/pass/pass_repository.dart';

class RequiredPassScreen extends StatelessWidget {
  final Booking booking;
  const RequiredPassScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final passRepo = context.read<PassRepository>();
    final globalPassState = context.read<GlobalPassState>();

    return ChangeNotifierProvider(
      create: (_) => PassSelectionViewModel(
        repository: passRepo,
        globalPassState: globalPassState,
      ),
      child: RequiredPassContent(booking: booking,),
    );
  }
}
