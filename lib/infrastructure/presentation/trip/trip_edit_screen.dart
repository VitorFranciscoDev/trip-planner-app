import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class TripEditScreen extends StatefulWidget {
  const TripEditScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<TripEditScreen> createState() => _TripEditScreenState();
}

class _TripEditScreenState extends State<TripEditScreen> {
  final TextEditingController _controllerTripTitle = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  String _dropdownValue = "Car";
  List<Person> _groupMembers = [];

  @override
  void initState() {
    super.initState();
    _controllerTripTitle.text = widget.trip.title;
    _dropdownValue = widget.trip.transport;
    _groupMembers = List.from(widget.trip.group ?? []);
  }

  @override
  void dispose() {
    _controllerTripTitle.dispose();
    _controllerName.dispose();
    _controllerAge.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final provider = context.read<TripProvider>();

    if (_controllerTripTitle.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Trip title is required"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (_groupMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Add at least one person to the group"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    final updatedTrip = Trip(
      id: widget.trip.id,
      user_id: widget.trip.user_id,
      title: _controllerTripTitle.text,
      transport: _dropdownValue,
      start_date: widget.trip.start_date,
      end_date: widget.trip.end_date,
      map_image: widget.trip.map_image,
      concluded: widget.trip.concluded,
      group: _groupMembers,
      stops: widget.trip.stops,
    );

    final result = await provider.updateTrip(updatedTrip, context);

    Navigator.of(context).pop();

    if (result == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("Trip updated successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text(result)),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(
          "Edit Trip",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Data Section
              Row(
                children: [
                  Icon(Icons.edit_note, color: theme.colorScheme.primary, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    "Trip Data",
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

              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
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
                      error: null,
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
                              Text("Car"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Motorcycle",
                          child: Row(
                            children: [
                              Icon(Icons.two_wheeler, size: 20),
                              const SizedBox(width: 8),
                              Text("Motorcycle"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Bus",
                          child: Row(
                            children: [
                              Icon(Icons.directions_bus, size: 20),
                              const SizedBox(width: 8),
                              Text("Bus"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Airplane",
                          child: Row(
                            children: [
                              Icon(Icons.flight, size: 20),
                              const SizedBox(width: 8),
                              Text("Airplane"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Ship",
                          child: Row(
                            children: [
                              Icon(Icons.directions_boat, size: 20),
                              const SizedBox(width: 8),
                              Text("Ship"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Group Section
              Row(
                children: [
                  Icon(Icons.group, color: theme.colorScheme.primary, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    "Travel Group",
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

              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
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
                      error: null,
                    ),
                    const SizedBox(height: 15),
                    TextFieldComponent(
                      controller: _controllerAge,
                      label: "Age",
                      error: null,
                    ),
                    const SizedBox(height: 20),
                    ButtonComponent(
                      function: () {
                        if (_controllerName.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Name is required"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final age = int.tryParse(_controllerAge.text);
                        if (age == null || age <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Valid age is required"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _groupMembers.add(
                            Person(name: _controllerName.text, age: age),
                          );
                        });

                        _controllerName.clear();
                        _controllerAge.clear();
                      },
                      message: "Add Person",
                    ),

                    if (_groupMembers.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 5),
                      Text(
                        "Group Members (${_groupMembers.length})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _groupMembers.map((person) {
                          return Chip(
                            avatar: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary,
                              child: Text(
                                person.name[0].toUpperCase(),
                                style: TextStyle(
                                  color: theme.colorScheme.tertiary,
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
                              setState(() {
                                _groupMembers.remove(person);
                              });
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
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              ButtonComponent(
                function: _saveChanges,
                message: "Save Changes",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}