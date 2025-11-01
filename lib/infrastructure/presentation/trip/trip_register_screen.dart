import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/map_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';

class TripRegisterScreen extends StatefulWidget {
  const TripRegisterScreen({super.key});

  @override
  State<TripRegisterScreen> createState() => _TripRegisterScreenState();
}

class _TripRegisterScreenState extends State<TripRegisterScreen> {
  // Controllers
  final TextEditingController _controllerTripTitle = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  // DropDown Value
  String _dropdownValue = "Car";

  // Add Trip
  Future<void> addTrip() async {
    final theme = Theme.of(context);
    final provider = context.read<TripProvider>();
    final userProvider = context.read<AuthProvider>();
    final currentContext = context;

    final isValid = provider.validateTrip(_controllerTripTitle.text, context);

    if (!isValid) return;

    Trip trip = Trip(
      user_id: userProvider.user!.id,
      title: _controllerTripTitle.text,
      transport: _dropdownValue,
      start_date: provider.stops.first.start_date,
      end_date: provider.stops.last.end_date,
      concluded: false,
      group: provider.group,
      stops: provider.stops,
    );

    final result = await provider.addTrip(trip);

    if (result == null) {
      // Successful Feedback Alert
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
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Success!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            "Trip created successfully!",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                provider.trip = null;
                provider.stops = [];
                provider.group = [];
                _controllerTripTitle.clear();
                _dropdownValue = "Car";
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
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
    } else {
      showDialog(
        // Error Feedback Alert
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
                  "Error",
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
            result,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final provider = context.watch<TripProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // Header
            Row(
              children: [
                Icon(
                  Icons.flight_takeoff,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  intl.newTrip,
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 24,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Trip Data Section Header
            Row(
              children: [
                Icon(Icons.edit_note, color: theme.colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  intl.tripData,
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 18,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Trip Data Card
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextFieldComponent(
                    controller: _controllerTripTitle,
                    label: "Trip Title",
                    error: provider.errorTripTitle,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Transport",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    value: _dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "Car",
                        child: Row(
                          children: [
                            Icon(Icons.directions_car, size: 20),
                            const SizedBox(width: 8),
                            Text(intl.car),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Motorcycle",
                        child: Row(
                          children: [
                            Icon(Icons.two_wheeler, size: 20),
                            const SizedBox(width: 8),
                            Text(intl.motorcycle),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Bus",
                        child: Row(
                          children: [
                            Icon(Icons.directions_bus, size: 20),
                            const SizedBox(width: 8),
                            Text(intl.bus),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Airplane",
                        child: Row(
                          children: [
                            Icon(Icons.flight, size: 20),
                            const SizedBox(width: 8),
                            Text(intl.airplane),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Ship",
                        child: Row(
                          children: [
                            Icon(Icons.directions_boat, size: 20),
                            const SizedBox(width: 8),
                            Text(intl.ship),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Group Data Section Header
            Row(
              children: [
                Icon(Icons.group, color: theme.colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  intl.groupData,
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 18,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Group Card
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldComponent(
                    controller: _controllerName,
                    label: "Name",
                    error: provider.errorName,
                  ),
                  const SizedBox(height: 15),
                  TextFieldComponent(
                    controller: _controllerAge,
                    label: "Age",
                    error: provider.errorAge,
                  ),
                  const SizedBox(height: 20),
                  ButtonComponent(
                    function: () {
                      final isValid = provider.validatePerson(
                        _controllerName.text,
                        _controllerAge.text,
                        context,
                      );

                      if (!isValid) return;

                      Person person = Person(
                        name: _controllerName.text,
                        age: int.parse(_controllerAge.text),
                      );

                      provider.addPerson(person);

                      _controllerName.clear();
                      _controllerAge.clear();
                    },
                    message: intl.addPerson,
                  ),

                  // Group Members
                  if (provider.group.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey[300]),
                    const SizedBox(height: 5),
                    Text(
                      "Group Members (${provider.group.length})",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: provider.group.map((person) {
                        return Chip(
                          avatar: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              person.name[0].toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          label: Text(
                            "${person.name} (${person.age})",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          deleteIcon: Icon(Icons.close, size: 18),
                          onDeleted: () {
                            provider.deletePerson(person);
                          },
                          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  // Group Error
                  if (provider.errorGroup != null) ...[
                    const SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              provider.errorGroup!,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Map Section Header
            Row(
              children: [
                Icon(Icons.map, color: theme.colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  intl.map,
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 18,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Map Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 220,
                                color: Colors.grey[200],
                                child: MapScreen(),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.fullscreen, color: Colors.white, size: 24),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MapScreen()),
                                  ),
                                  tooltip: "Fullscreen Map",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Stops Error
                  if (provider.errorStops != null)
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              provider.errorStops!,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Register Button
            ButtonComponent(
              function: addTrip,
              message: intl.registerTrip,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}