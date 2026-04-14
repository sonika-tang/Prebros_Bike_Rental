import 'package:bike_rental/data/repositories/station/station_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StationRepositoryFirebase implements StationRepository {
  static final Uri baseUri = Uri.https(dotenv.env['FIREBASE_DB_URL'] ?? '');
  static final Uri stationUrl = baseUri.replace(path: '/stations.json');
}