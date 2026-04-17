import 'package:bike_rental/models/pass.dart';

abstract class PassRepository {
  Future<List<Pass>> getAvailablePasses();
  Future<void> purchasePass(Pass pass, String userId);
}
