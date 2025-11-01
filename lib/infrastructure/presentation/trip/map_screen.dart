import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/stop_experience.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/checkbox_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_date_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Controller of Map
  final MapController _mapController = MapController();
  
  // Controller for Dates Text Fields
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // User's Current Location
  LatLng? _currentLocation;

  // Map's Markers and Points
  List<Marker> _markers = [];
  List<LatLng> _points = [];

  // Checkbox boolean variables
  bool _differentCulture = false;
  bool _alternativeCuisine = false;
  bool _historicalSites = false;
  bool _localEstablishments = false;
  bool _contactWithNature = false;

  // Request User's Permission and Get His Current Position
  Future<void> _requestPermissionAndLocate() async {
    final status = await Permission.location.request();
    if (!status.isGranted) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  // Date Picker
  Future<void> _selectDate(TextEditingController controller) async {
    final provider = context.read<TripProvider>();
    
    DateTime firstAvailableDate = DateTime.now();
    
    if (provider.stops.isNotEmpty) {
      final lastStop = provider.stops.last;
      final dateParts = lastStop.end_date.split('/');
      
      if (dateParts.length == 3) {
        final day = int.tryParse(dateParts[0]);
        final month = int.tryParse(dateParts[1]);
        final year = int.tryParse(dateParts[2]);
        
        if (day != null && month != null && year != null) {
          firstAvailableDate = DateTime(year, month, day);
        }
      }
    }
    
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: firstAvailableDate,
      firstDate: firstAvailableDate,
      lastDate: DateTime(2030),
    );

    if (_picked != null) {
      controller.text = "${_picked.day}/${_picked.month}/${_picked.year}";
    }
  }

  Future<void> _onMarkerTap(int index) async {
    final provider = context.read<TripProvider>();
    final theme = Theme.of(context);
    final stop = provider.stops[index];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.location_on, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                stop.location,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dates: ${stop.start_date} - ${stop.end_date}",
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            if (stop.stopExperiences!.isNotEmpty) ...[
              Text(
                "Experiences:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              ...stop.stopExperiences!.map((exp) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Text(
                  "• ${exp.experience}",
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              )),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
            ),
            child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _onEditStop(index);
            },
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
            ),
            child: const Text("Edit", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _onDeleteStop(index);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text("Delete", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _onEditStop(int index) async {
    final provider = context.read<TripProvider>();
    final theme = Theme.of(context);
    final stop = provider.stops[index];

    _startDateController.text = stop.start_date;
    _endDateController.text = stop.end_date;
    
    _differentCulture = stop.stopExperiences!.any((e) => e.experience == "Immersion in a Different Culture");
    _alternativeCuisine = stop.stopExperiences!.any((e) => e.experience == "Explore Alternative Cuisines");
    _historicalSites = stop.stopExperiences!.any((e) => e.experience == "Visit Historical Sites");
    _localEstablishments = stop.stopExperiences!.any((e) => e.experience == "Visit Local Establishments");
    _contactWithNature = stop.stopExperiences!.any((e) => e.experience == "Contact With Nature");

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.edit_location, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Edit ${stop.location}",
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
                foregroundColor: theme.colorScheme.primary,
              ),
              child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () async {
                final isValid = provider.validateStopDates(_startDateController.text, _endDateController.text);

                if (!isValid) return;

                final List<StopExperience> _experiences = [];

                if (_differentCulture) {
                  _experiences.add(StopExperience(experience: "Immersion in a Different Culture"));
                }

                if (_alternativeCuisine) {
                  _experiences.add(StopExperience(experience: "Explore Alternative Cuisines"));
                }

                if (_historicalSites) {
                  _experiences.add(StopExperience(experience: "Visit Historical Sites"));
                }

                if (_localEstablishments) {
                  _experiences.add(StopExperience(experience: "Visit Local Establishments"));
                }

                if (_contactWithNature) {
                  _experiences.add(StopExperience(experience: "Contact With Nature"));
                }

                final updatedStop = Stop(
                  location: stop.location,
                  start_date: _startDateController.text,
                  end_date: _endDateController.text,
                  latitude: stop.latitude,
                  longitude: stop.longitude,
                  stopExperiences: _experiences,
                );

                provider.updateStop(index, updatedStop);

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.tertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Save Changes", style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeleteStop(int index) async {
    final provider = context.read<TripProvider>();
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              "Delete Stop",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to delete this stop? This action cannot be undone.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
            ),
            child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () async {
              provider.deleteStop(index);

              setState(() {
                _markers.removeAt(index);
                _points.removeAt(index);
              });

              if (_points.isNotEmpty) {
                final routedPoints = await provider.getRoute(_points);
                setState(() {
                  _points = routedPoints;
                });
              }

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Delete", style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Future<void> _onMapTap(LatLng latlng) async {
    final provider = context.read<TripProvider>();
    final theme = Theme.of(context);

    final address = await provider.getAddressFromCoordinates(latlng);
    final locationName = address ?? "Unknown Place";

    _differentCulture = false;
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
                foregroundColor: theme.colorScheme.primary,
              ),
              child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                final isValid = provider.validateStopDates(_startDateController.text, _endDateController.text);

                if (!isValid) return;

                final List<StopExperience> _experiences = [];

                if (_differentCulture) {
                  _experiences.add(StopExperience(experience: "Immersion in a Different Culture"));
                }

                if (_alternativeCuisine) {
                  _experiences.add(StopExperience(experience: "Explore Alternative Cuisines"));
                }

                if (_historicalSites) {
                  _experiences.add(StopExperience(experience: "Visit Historical Sites"));
                }

                if (_localEstablishments) {
                  _experiences.add(StopExperience(experience: "Visit Local Establishments"));
                }

                if (_contactWithNature) {
                  _experiences.add(StopExperience(experience: "Contact With Nature"));
                }

                if(_experiences.isEmpty) {
                  showDialog(
                    context: currentContext,
                    builder: (dialogContext) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.error, color: Colors.red, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Error in Add Stop",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: Text(
                        "You need to have, at least, one experience.",
                        style: TextStyle(fontSize: 14),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: theme.colorScheme.tertiary,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Ok",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                final stop = Stop(
                  location: locationName,
                  start_date: _startDateController.text,
                  end_date: _endDateController.text,
                  latitude: latlng.latitude,
                  longitude: latlng.longitude,
                  stopExperiences: _experiences,
                );

                provider.addStop(stop);

                final markerIndex = _markers.length;

                setState(() {
                  _markers.add(
                    Marker(
                      point: latlng,
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => _onMarkerTap(markerIndex),
                        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ),
                  );
                  _points.add(latlng);
                });

                final routedPoints = await provider.getRoute(_points);

                setState(() {
                  _points = routedPoints;
                });

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.tertiary,
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
      for (int i = 0; i < provider.stops.length; i++) {
        final stop = provider.stops[i];
        final latlng = LatLng(stop.latitude, stop.longitude);
        final index = i;
        
        _points.add(latlng);
        _markers.add(
          Marker(
            point: latlng,
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => _onMarkerTap(index),
              child: Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ),
        );
      }

      provider.getRoute(_points).then((routedPoints) {
        if (mounted) {
          setState(() {
            _points = routedPoints;
          });
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
    final provider = context.watch<TripProvider>();

    if(_currentLocation == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
              initialCenter: provider.stops.isNotEmpty ? LatLng(provider.stops[0].latitude, provider.stops[0].longitude) : _currentLocation!,
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
                      strokeWidth: 6,
                      color: theme.colorScheme.primary,
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