import 'package:bike_rental/ui/screens/details_screen/details_plan_screen.dart';
import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:bike_rental/ui/utils/async_value.dart';
import 'package:bike_rental/ui/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/repositories/pass/pass_repository.dart';
import 'view_model/pass_selection_vm.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passRepo = context.read<PassRepository>();
    final globalPassState = context.read<GlobalPassState>();

    return ChangeNotifierProvider(
      create: (_) => PassSelectionViewModel(
        repository: passRepo,
        globalPassState: globalPassState,
      ),
      child: Consumer<PassSelectionViewModel>(
        builder: (context, vm, _) {
          final asyncValue = vm.passesValue;

          if (asyncValue.state == AsyncValueState.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (asyncValue.state == AsyncValueState.error) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error: ${asyncValue.error}',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            );
          }

          final passes = asyncValue.data!;
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Subscription options",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            body: RefreshIndicator(
              onRefresh: () async => vm.fetchPasses(forceFetch: true),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: passes.length,
                itemBuilder: (context, index) {
                  final pass = passes[index];
                  final isActive =
                      context.watch<GlobalPassState>().activePass?.passId ==
                      pass.passId;

                  return PlanCard(
                    pass: pass,
                    isActive: isActive,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: vm,
                            child: PlanDetailsScreen(pass: pass),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
