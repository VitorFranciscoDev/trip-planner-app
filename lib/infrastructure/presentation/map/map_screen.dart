import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<Marker> _markers = [];
  List<LatLng> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(0, 0),
              initialZoom: 2,
              minZoom: 0,
              maxZoom: 100,
              onTap: (tapPosition, latlng) {
                setState(() {
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