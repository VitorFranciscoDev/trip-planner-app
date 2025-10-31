import 'package:latlong2/latlong.dart';

// Stop's Contracts
abstract class IStopRepository {
  Future<String?> getAddressFromCoordinates(LatLng position);
  Future<List<LatLng>> getRoute(List<LatLng> points);
}