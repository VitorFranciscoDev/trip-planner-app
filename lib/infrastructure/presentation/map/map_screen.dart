import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_state.dart';
import 'package:trip_planner/modules/stop/stop_usecase.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  LatLng? _currentLocation;

  final List<Marker> _markers = [];
  final List<LatLng> _points = [];

  StopUseCase stopUseCase = StopUseCase();

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if(status.isGranted) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
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
              onTap: (tapPosition, latlng) async {
                final locationData = await stopUseCase.reverseGeocode(latlng.latitude, latlng.longitude);
                final locationName = locationData["city"] ?? "Unknown";

                setState(() {
                  context.read<StopsProvider>().addStop(locationName);
                  _markers.add(
                    Marker(
                      point: latlng,
                      width: 40,
                      height: 40, 
                      child: Icon(Icons.location_on, color: Colors.red),
                    ),
                  );
                  _points.add(latlng);
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              if(_currentLocation != null)
                CurrentLocationLayer(
                  style: const LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(Icons.location_pin, color: Colors.red),
                    ),
                    markerSize: Size(20, 20),
                    markerDirection: MarkerDirection.heading,
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