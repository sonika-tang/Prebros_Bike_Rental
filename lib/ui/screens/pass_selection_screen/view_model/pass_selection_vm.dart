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
      await repository.purchasePass(pass, userId);
      globalPassState.setActivePass(pass);
    } catch (e) {
    }
    notifyListeners();
  }
}
