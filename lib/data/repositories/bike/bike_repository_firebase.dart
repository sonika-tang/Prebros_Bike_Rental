import 'package:bike_rental/data/repositories/bike/bike_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BikeRepositoryFirebase implements BikeRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri bikeUrl = baseUri.replace(path: '/bikes.json');
}