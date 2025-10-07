import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? currentLocation;
  List<Marker> markers = [];
  List<LatLng> points = [];

  Future<void> requestPermission() async {
    final status = await Permission.location.request();
    if(status.isGranted) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentLocation ?? LatLng(0, 0),
              initialZoom: 13,
              minZoom: 0,
              maxZoom: 19,
              onTap: (tapPosition, latlng) {
                setState(() {
                  markers.add(
                    Marker(
                      point: latlng,
                      width: 40,
                      height: 40, 
                      child: Icon(Icons.location_on, color: Colors.red),
                    ),
                  );
                  points.add(latlng);
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              if(currentLocation != null)
                CurrentLocationLayer(
                  style: const LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(Icons.location_pin, color: Colors.red),
                    ),
                    markerSize: Size(20, 20),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              MarkerLayer(markers: markers),
              PolylineLayer(
                polylines: [
                  if (points.isNotEmpty)
                    Polyline(
                      points: points,
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