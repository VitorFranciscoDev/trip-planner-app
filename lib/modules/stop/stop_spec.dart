import 'package:latlong2/latlong.dart';

// Stop's Contracts
abstract class IStopRepository {
  Future<String?> getAddressFromCoordinates(LatLng position);
}