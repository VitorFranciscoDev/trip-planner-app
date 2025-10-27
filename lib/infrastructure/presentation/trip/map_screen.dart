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
import 'package:trip_planner/entities/user_experience.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/checkbox_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_date_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/modules/stop/stop_repository.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final StopRepository _stopRepository = StopRepository();
  
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  LatLng? _currentLocation;

  List<Marker> _markers = [];
  List<LatLng> _points = [];

  bool _differentCulture = true;
  bool _alternativeCuisine = false;
  bool _historicalSites = false;
  bool _localEstablishments = false;
  bool _contactWithNature = false;

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

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> _onMapTap(LatLng latlng) async {
    final provider = context.read<TripProvider>();
    final theme = Theme.of(context);

    final address = await _stopRepository.getAddressFromCoordinates(latlng);
    final locationName = address ?? "Unknown Place";

    _differentCulture = true;
    _alternativeCuisine = false;
    _historicalSites = false;
    _localEstablishments = false;
    _contactWithNature = false;
    
    _startDateController.clear();
    _endDateController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.location_on, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  locationName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Dates",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _startDateController,
                  hint: "Start Date",
                  error: provider.errorStartDate,
                  function: () => _selectDate(_startDateController),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _endDateController,
                  hint: "End Date",
                  error: provider.errorEndDate,
                  function: () => _selectDate(_endDateController),
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Experiences",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                CheckboxComponent(
                  value: _differentCulture,
                  label: "Immersion in a Different Culture",
                  icon: Icons.public,
                  onChanged: (value) {
                    setDialogState(() {
                      _differentCulture = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _alternativeCuisine,
                  label: "Explore Alternative Cuisines",
                  icon: Icons.restaurant,
                  onChanged: (value) {
                    setDialogState(() {
                      _alternativeCuisine = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _historicalSites,
                  label: "Visit Historical Sites",
                  icon: Icons.account_balance,
                  onChanged: (value) {
                    setDialogState(() {
                      _historicalSites = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _localEstablishments,
                  label: "Visit Local Establishments",
                  icon: Icons.store,
                  onChanged: (value) {
                    setDialogState(() {
                      _localEstablishments = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _contactWithNature,
                  label: "Contact With Nature",
                  icon: Icons.nature,
                  onChanged: (value) {
                    setDialogState(() {
                      _contactWithNature = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validate dates
                /*
                final isValid = provider.validateStopDates(
                  startDate: _startDateController.text,
                  endDate: _endDateController.text,
                  context: context,
                );
                

                if (!isValid) {
                  // Force rebuild to show errors
                  setDialogState(() {});
                  return;
                }

                */

                final experiences = <UserExperience>[];

                if (_differentCulture) {
                  experiences.add(UserExperience(experience: "Immersion in a Different Culture"));
                }
                if (_alternativeCuisine) {
                  experiences.add(UserExperience(experience: "Explore Alternative Cuisines"));
                }
                if (_historicalSites) {
                  experiences.add(UserExperience(experience: "Visit Historical Sites"));
                }
                if (_localEstablishments) {
                  experiences.add(UserExperience(experience: "Visit Local Establishments"));
                }
                if (_contactWithNature) {
                  experiences.add(UserExperience(experience: "Contact With Nature"));
                }

                final stop = Stop(
                  location: locationName,
                  start_date: _startDateController.text,
                  end_date: _endDateController.text,
                  latitude: latlng.latitude,
                  longitude: latlng.longitude,
                  userExperiences: experiences,
                );
                provider.addStop(stop);

                setState(() {
                  _markers.add(
                    Marker(
                      point: latlng,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  );
                  _points.add(latlng);
                });

                final routedPoints = await _getRoute(_points);
                setState(() {
                  _points = routedPoints;
                });

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Add Stop", style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLocate();
    final provider = context.read<TripProvider>();
    
    if (provider.stops.isNotEmpty) {
      for (final stop in provider.stops) {
        final latlng = LatLng(stop.latitude, stop.longitude);
        
        _points.add(latlng);
        _markers.add(
          Marker(
            point: latlng,
            width: 40,
            height: 40,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
      }

      _getRoute(_points).then((routedPoints) {
        if (mounted) {
          setState(() {
            _points = routedPoints;
          });
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _mapController.move(
            LatLng(provider.stops.first.latitude, provider.stops.first.longitude),
            13,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mapController.move(_currentLocation!, 15),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.location_on, color: theme.colorScheme.tertiary),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation!,
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
              if (_currentLocation != null)
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      color: const Color.fromARGB(255, 0, 99, 181),
                      child: const SizedBox(),
                    ),
                    markerSize: const Size(15, 15),
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