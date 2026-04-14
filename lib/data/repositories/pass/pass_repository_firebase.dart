import 'package:bike_rental/data/repositories/pass/pass_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PassRepositoryFirebase implements PassRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri passUrl = baseUri.replace(path: '/passes.json');
}