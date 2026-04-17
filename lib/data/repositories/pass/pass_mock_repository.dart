import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental/models/pass.dart';

class MockPassRepository implements PassRepository {
  @override
  Future<List<Pass>> getAvailablePasses() async {
    return [
      Pass(
        passId: 'cat_day',
        type: PassType.day,
        price: 2.0,
        startDate: null,
        endDate: null,
        isActive: false,
      ),
      Pass(
        passId: 'cat_weekly',
        type: PassType.weekly,
        price: 5.0,
        startDate: null,
        endDate: null,
        isActive: false,
      ),
      Pass(
        passId: 'cat_monthly',
        type: PassType.monthly,
        price: 15.0,
        startDate: null,
        endDate: null,
        isActive: false,
      ),
      Pass(
        passId: 'cat_annual',
        type: PassType.annual,
        price: 150.0,
        startDate: null,
        endDate: null,
        isActive: false,
      ),
    ];
  }

  @override
  Future<void> purchasePass(Pass pass, String userId) async {
    print("Mock purchase: User $userId purchased ${pass.typeName}");
  }
}
