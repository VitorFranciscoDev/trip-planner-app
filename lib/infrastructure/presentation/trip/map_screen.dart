import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final GlobalKey _mapKey = GlobalKey();
  final MapController _mapController = MapController();
  
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  LatLng? _currentLocation;

  final List<Marker> _markers = [];
  List<LatLng> _points = [];

  bool _differentCulture = false;
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
  }

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
    final intl = AppLocalizations.of(context);
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
                intl.experiences,
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
            child: Text(intl.cancel, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _onEditStop(index);
            },
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
            ),
            child: Text(intl.edit, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _onDeleteStop(index);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(intl.delete, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _onEditStop(int index) async {
    final provider = context.read<TripProvider>();
    final intl = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final stop = provider.stops[index];

    _startDateController.text = stop.start_date;
    _endDateController.text = stop.end_date;
    
    _differentCulture = stop.stopExperiences!.any((e) => e.experience == intl.immersionDifferentCulture);
    _alternativeCuisine = stop.stopExperiences!.any((e) => e.experience == intl.exploreAlternativeCuisines);
    _historicalSites = stop.stopExperiences!.any((e) => e.experience == intl.visitHistoricalSites);
    _localEstablishments = stop.stopExperiences!.any((e) => e.experience == intl.visitLocalEstablishments);
    _contactWithNature = stop.stopExperiences!.any((e) => e.experience == intl.contactWithNature);

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
                  intl.selectDates,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _startDateController,
                  hint: intl.startDate,
                  error: provider.errorStartDate,
                  function: () => _selectDate(_startDateController),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _endDateController,
                  hint: intl.endDate,
                  error: provider.errorEndDate,
                  function: () => _selectDate(_endDateController),
                ),
                const SizedBox(height: 20),
                Text(
                  intl.selectExperiences,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                CheckboxComponent(
                  value: _differentCulture,
                  label: intl.immersionDifferentCulture,
                  icon: Icons.public,
                  onChanged: (value) {
                    setDialogState(() {
                      _differentCulture = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _alternativeCuisine,
                  label: intl.exploreAlternativeCuisines,
                  icon: Icons.restaurant,
                  onChanged: (value) {
                    setDialogState(() {
                      _alternativeCuisine = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _historicalSites,
                  label: intl.visitHistoricalSites,
                  icon: Icons.account_balance,
                  onChanged: (value) {
                    setDialogState(() {
                      _historicalSites = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _localEstablishments,
                  label: intl.visitLocalEstablishments,
                  icon: Icons.store,
                  onChanged: (value) {
                    setDialogState(() {
                      _localEstablishments = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _contactWithNature,
                  label: intl.contactWithNature,
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
              child: Text(intl.cancel, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                final isValid = provider.validateStopDates(_startDateController.text, _endDateController.text, context);

                if (!isValid) return;

                final List<StopExperience> _experiences = [];

                if (_differentCulture) {
                  _experiences.add(StopExperience(experience: intl.immersionDifferentCulture));
                }

                if (_alternativeCuisine) {
                  _experiences.add(StopExperience(experience: intl.exploreAlternativeCuisines));
                }

                if (_historicalSites) {
                  _experiences.add(StopExperience(experience: intl.visitHistoricalSites));
                }

                if (_localEstablishments) {
                  _experiences.add(StopExperience(experience: intl.visitLocalEstablishments));
                }

                if (_contactWithNature) {
                  _experiences.add(StopExperience(experience: intl.contactWithNature));
                }

                final updatedStop = Stop(
                  location: stop.location,
                  start_date: _startDateController.text,
                  end_date: _endDateController.text,
                  latitude: stop.latitude,
                  longitude: stop.longitude,
                  stopExperiences: _experiences,
                );

                showDialog(
                  context: currentContext,
                  barrierDismissible: false,
                  builder: (_) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                provider.updateStop(index, updatedStop);

                Navigator.of(context).pop();

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.tertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(intl.saveChanges, style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeleteStop(int index) async {
    final provider = context.read<TripProvider>();
    final intl = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentContext = context;

    showDialog(
      context: currentContext,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              intl.deleteStop,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ],
        ),
        content: Text(
          intl.deleteStopConfirm,
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
            ),
            child: Text(intl.cancel, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () async {
              provider.deleteStop(index);

              setState(() {
                _markers.removeAt(index);
                _points.removeAt(index);
              });

              showDialog(
                context: currentContext,
                barrierDismissible: false,
                builder: (_) => Center(
                  child: CircularProgressIndicator(),
                ),
              );

              if (_points.isNotEmpty) {
                final routedPoints = await provider.getRoute(_points);
                setState(() {
                  _points = routedPoints;
                });
              }

              Navigator.of(context).pop();

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: theme.colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(intl.delete, style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Future<void> _onMapTap(LatLng latlng) async {
    final provider = context.read<TripProvider>();
    final intl = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentContext = context;

    final address = await provider.getAddressFromCoordinates(latlng);
    final locationName = address ?? intl.unknownPlace;

    _differentCulture = false;
    _alternativeCuisine = false;
    _historicalSites = false;
    _localEstablishments = false;
    _contactWithNature = false;
    
    _startDateController.clear();
    _endDateController.clear();

    showDialog(
      context: currentContext,
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
                  intl.selectDates,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _startDateController,
                  hint: intl.startDate,
                  error: provider.errorStartDate,
                  function: () => _selectDate(_startDateController),
                ),
                const SizedBox(height: 12),
                TextFieldDateComponent(
                  controller: _endDateController,
                  hint: intl.endDate,
                  error: provider.errorEndDate,
                  function: () => _selectDate(_endDateController),
                ),
                const SizedBox(height: 20),
                Text(
                  intl.selectExperiences,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                CheckboxComponent(
                  value: _differentCulture,
                  label: intl.immersionDifferentCulture,
                  icon: Icons.public,
                  onChanged: (value) {
                    setDialogState(() {
                      _differentCulture = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _alternativeCuisine,
                  label: intl.exploreAlternativeCuisines,
                  icon: Icons.restaurant,
                  onChanged: (value) {
                    setDialogState(() {
                      _alternativeCuisine = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _historicalSites,
                  label: intl.visitHistoricalSites,
                  icon: Icons.account_balance,
                  onChanged: (value) {
                    setDialogState(() {
                      _historicalSites = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _localEstablishments,
                  label: intl.visitLocalEstablishments,
                  icon: Icons.store,
                  onChanged: (value) {
                    setDialogState(() {
                      _localEstablishments = value!;
                    });
                  },
                ),
                CheckboxComponent(
                  value: _contactWithNature,
                  label: intl.contactWithNature,
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
              child: Text(intl.cancel, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                final isValid = provider.validateStopDates(_startDateController.text, _endDateController.text, currentContext);

                if (!isValid) return;

                final List<StopExperience> _experiences = [];

                if (_differentCulture) {
                  _experiences.add(StopExperience(experience: intl.immersionDifferentCulture));
                }

                if (_alternativeCuisine) {
                  _experiences.add(StopExperience(experience: intl.exploreAlternativeCuisines));
                }

                if (_historicalSites) {
                  _experiences.add(StopExperience(experience: intl.visitHistoricalSites));
                }

                if (_localEstablishments) {
                  _experiences.add(StopExperience(experience: intl.visitLocalEstablishments));
                }

                if (_contactWithNature) {
                  _experiences.add(StopExperience(experience: intl.contactWithNature));
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
                              intl.errorAddStopTitle,
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
                        intl.errorAddStopMsg,
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
                            intl.ok,
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
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () => _onMarkerTap(markerIndex),
                        child: const Icon(Icons.location_on, color: Colors.red, size: 50),
                      ),
                    ),
                  );
                  _points.add(latlng);
                });

                showDialog(
                  context: currentContext,
                  barrierDismissible: false,
                  builder: (_) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                final routedPoints = await provider.getRoute(_points);

                setState(() {
                  _points = routedPoints;
                });

                Navigator.of(currentContext).pop();

                Navigator.of(currentContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.tertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(intl.addStop, style: TextStyle(fontWeight: FontWeight.w700)),
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
            width: 50,
            height: 50,
            child: GestureDetector(
              onTap: () => _onMarkerTap(index),
              child: Icon(Icons.location_on, color: Colors.red, size: 50),
            ),
          ),
        );
      }

      provider.getRoute(_points).then((routedPoints) {
        setState(() {
          _points = routedPoints;
        });
      });
    }
  }

  Future<Uint8List?> captureMapScreenshot() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      await WidgetsBinding.instance.endOfFrame;
      
      final RenderObject? renderObject = _mapKey.currentContext?.findRenderObject();
      
      if (renderObject == null) {
        debugPrint('Error: RenderObject is null');
        return null;
      }
      
      if (renderObject is! RenderRepaintBoundary) {
        debugPrint('Error: RenderObject is not a RenderRepaintBoundary');
        return null;
      }
      
      final RenderRepaintBoundary boundary = renderObject;
      
      if (boundary.debugNeedsPaint) {
        debugPrint('Warning: Boundary needs paint, waiting...');
        await Future.delayed(const Duration(milliseconds: 300));
      }
      
      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        debugPrint('Error: Failed to convert image to ByteData');
        return null;
      }
      
      debugPrint('Screenshot captured successfully: ${byteData.lengthInBytes} bytes');
      return byteData.buffer.asUint8List();
    } catch (e, stackTrace) {
      debugPrint('Error in captureMapScreenshot: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
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
          RepaintBoundary(
            key: _mapKey,
            child: FlutterMap(
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
          ),
        ],
      ),
    );
  }
}