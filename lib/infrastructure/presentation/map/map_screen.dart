import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_state.dart';
import 'package:trip_planner/modules/search-result/search_result_repository.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final SearchResultService _searchResultService = SearchResultService();

  LatLng? _currentLocation;

  List<Marker> _markers = [];
  List<LatLng> _points = [];

  Future<void> _requestPermissionAndLocate() async {
    final status = await Permission.location.request();
    if (!status.isGranted) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(_currentLocation!, 15);
  }

  Future<List<LatLng>> _getRoute(List<LatLng> points) async {
    if (points.length < 2) return points;

    final coords = points.map((p) => "${p.longitude},${p.latitude}").join(";");
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/$coords?overview=full&geometries=geojson",
    );

    final response = await http.get(url);
    if (response.statusCode != 200) return points;

    final data = json.decode(response.body);
    final route = data['routes'][0]['geometry']['coordinates'] as List;
    return route
        .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
        .toList();
  }

  Future<void> _onMapTap(LatLng latlng) async {
    final provider = context.read<StopsProvider>();

    final address = await _searchResultService.getAddressFromCoordinates(latlng);
    final locationName = address ?? "Unknown location";

    final stop = Stop(
      location: locationName,
      latitude: latlng.latitude,
      longitude: latlng.longitude,
    );
    provider.addStop(stop);

    setState(() {
      _markers.add(
        Marker(
          point: latlng,
          width: 40,
          height: 40,
          child: const Icon(Icons.location_on, color: Colors.red),
        ),
      );
      _points.add(latlng);
    });

    final routedPoints = await _getRoute(_points);
    setState(() {
      _points = routedPoints;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLocate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(-22.908333, -43.196388),
              initialZoom: 13,
              minZoom: 0,
              maxZoom: 19,
              onTap: (tapPosition, latlng) => _onMapTap(latlng),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.trip_planner',
                tileProvider: NetworkTileProvider(),
              ),
              if(_currentLocation != null)
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      color: Colors.blue.withOpacity(0.3),
                      child: const SizedBox(),
                    ),
                    markerSize: const Size(50, 50),
                    accuracyCircleColor: Colors.blue.withOpacity(0.1),
                    showAccuracyCircle: true,
                  ),
                ),
              MarkerLayer(markers: _markers),
              PolylineLayer(
                polylines: [
                  if (_points.isNotEmpty)
                    Polyline(
                      points: _points,
                      strokeWidth: 4,
                      color: Colors.red,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}