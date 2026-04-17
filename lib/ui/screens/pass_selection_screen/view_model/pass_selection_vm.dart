import 'package:bike_rental/ui/states/active_pass_state.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/pass/pass_repository.dart';
import '../../../../models/pass.dart';
import '../../../utils/async_value.dart';

class PassSelectionViewModel extends ChangeNotifier {
  final PassRepository repository;
  final GlobalPassState globalPassState;

  AsyncValue<List<Pass>> passesValue = AsyncValue.loading();

  PassSelectionViewModel({
    required this.repository,
    required this.globalPassState,
  }) {
    _init();
  }

  void _init() async {
    fetchPasses();
  }

  Future<void> fetchPasses({bool forceFetch = false}) async {
    passesValue = AsyncValue.loading();
    notifyListeners();

    try {
      final passes = await repository.getAvailablePasses();
      passesValue = AsyncValue.success(passes);
    } catch (e) {
      passesValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> purchasePass(Pass pass, String userId) async {
    try {
      final now = DateTime.now();
      late DateTime end;

      switch (pass.type) {
        case PassType.day:
          end = now.add(const Duration(days: 1));
          break;
        case PassType.weekly:
          end = now.add(const Duration(days: 7));
          break;
        case PassType.monthly:
          end = now.add(const Duration(days: 30));
          break;
        case PassType.annual:
          end = now.add(const Duration(days: 365));
          break;
      }

      // Create updated pass with start/end dates
      final updatedPass = Pass(
        passId: pass.passId,
        type: pass.type,
        price: pass.price,
        startDate: now,
        endDate: end,
        isActive: true,
      );

      // Save to Firebase via repository
      await repository.purchasePass(updatedPass, userId);

      // Update global state so UI reflects immediately
      globalPassState.setActivePass(updatedPass);
    } catch (e) {
      // TODO: handle error (e.g., show snackbar or log)
    }
    notifyListeners();
  }
}