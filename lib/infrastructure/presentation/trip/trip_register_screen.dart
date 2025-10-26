import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
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
  // controllers
  TextEditingController controllerTripTitle = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();

  String dropdownValue = "Car";

  Future<void> registerTrip() async {
    final provider = context.read<TripProvider>();
    final userProvider = context.read<AuthProvider>();

    // Validate trip
    final isValid = provider.validateTrip(
      tripTitle: controllerTripTitle.text,
      group: provider.group,
      stops: provider.stops,
      context: context,
    );

    if (!isValid) return;

    Trip trip = Trip(
      user_id: userProvider.user?.id,
      title: controllerTripTitle.text,
      transport: dropdownValue,
      start_date: provider.stops[0].start_date,
      end_date: provider.stops[0-1].end_date,
      concluded: false,
      group: provider.group,
      stops: provider.stops,
    );

    final result = await provider.createTrip(trip, context);

    if (result == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success!"),
          content: const Text("Trip created successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controllerTripTitle.clear();
                setState(() {
                  dropdownValue = "Car";
                });
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<TripProvider>();

    if(provider.trip != null) {
      controllerTripTitle.text = provider.trip!.title;
      dropdownValue = provider.trip!.transport;
      provider.stops = provider.trip!.stops;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final provider = context.watch<TripProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              intl.newTrip,
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 20,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              intl.tripData,
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 20,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerTripTitle,
                      hint: intl.tripTitle,
                      error: provider.errorTripTitle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
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
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: "Car",
                          child: Text(intl.car),
                        ),
                        DropdownMenuItem(
                          value: "Motorcycle",
                          child: Text(intl.motorcycle),
                        ),
                        DropdownMenuItem(
                          value: "Bus",
                          child: Text(intl.bus),
                        ),
                        DropdownMenuItem(
                          value: "Airplane",
                          child: Text(intl.airplane),
                        ),
                        DropdownMenuItem(
                          value: "Ship",
                          child: Text(intl.ship),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              intl.groupData,
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 20,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerName,
                      hint: intl.name,
                      error: provider.errorName,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: TextFieldComponent(
                      controller: controllerAge,
                      hint: intl.age,
                      error: provider.errorAge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: ButtonComponent(
                      function: () {
                        final isValid = provider.validatePerson(
                          controllerName.text,
                          controllerAge.text,
                          context,
                        );
                        
                        if (!isValid) return;

                        Person person = Person(
                          name: controllerName.text,
                          age: int.parse(controllerAge.text),
                        );

                        provider.addPerson(person);
                        
                        controllerName.clear();
                        controllerAge.clear();
                      }, 
                      message: intl.addPerson,
                    ),
                  ),
                  if (provider.group.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Wrap(
                        children: [
                          ...provider.group.map((person) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Chip(
                                label: Text("${person.name}(${person.age})"),
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  provider.removePerson(person);
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  if (provider.errorGroup != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        provider.errorGroup!,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              intl.map,
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 20,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: Center(
                                child: MapScreen(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.fullscreen, color: theme.colorScheme.tertiary),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MapScreen()),
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (provider.stops.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        children: [
                          ...provider.stops.map((stop) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Chip(
                                label: Text(stop.location),
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  provider.removeStop(stop);
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  if (provider.errorStops != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        provider.errorStops!,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 65),
            child: ButtonComponent(
              function: registerTrip, 
              message: intl.registerTrip,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}