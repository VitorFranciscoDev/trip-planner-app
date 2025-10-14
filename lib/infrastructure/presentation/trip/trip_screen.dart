import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_date_component.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_screen.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/group_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  
  // 1. controllers
  TextEditingController controllerTripTitle = TextEditingController();
  TextEditingController controllerStartDate = TextEditingController();
  TextEditingController controllerEndDate = TextEditingController();

  // 2. controllers
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();

  String dropdownValue = "Car"; // value of the DropdownButton

  // 1. errors
  String? errorTripTitle;
  String? errorStartDate;
  String? errorEndDate;
  String? errorDate;

  // 2. errors
  String? errorName;
  String? errorAge;
  String? errorGroup;
  
  String? errorStops; // 3. errors

  final TripUseCase tripUseCase = TripUseCase(); // use cases of the trip

  final PersonUseCase personUseCase = PersonUseCase(); // use cases of the group

  // function to verify and register all the trip data
  Future<void> registerGroup(List<Person> group, List<Stop> stops) async {

    setState(() {
      // errors
      errorTripTitle = tripUseCase.validateTripTitle(controllerTripTitle.text);
      errorStartDate = tripUseCase.validateStartDate(controllerStartDate.text);
      errorEndDate = tripUseCase.validateEndDate(controllerEndDate.text);
      if(errorStartDate==null && errorEndDate==null) {
        errorDate = tripUseCase.validateDates(controllerStartDate.text, controllerEndDate.text);
      }
      errorGroup = tripUseCase.validateGroup(group);
      errorStops = tripUseCase.validateStops(stops);
    });

    // if doesn't have any errors, add the trip in the db
    if(errorTripTitle==null && errorStartDate==null && errorEndDate==null && errorDate == null && errorGroup == null && errorStops == null) {
      Trip trip = Trip(title: controllerTripTitle.text, transport: dropdownValue, startDate: controllerStartDate.text, endDate: controllerEndDate.text, group: group, stops: stops);
      context.read<TripProvider>().addTrip(trip);
    }
  }

  // function to verify and add a person in the group
  void addPerson() {
    setState(() {
      errorName = personUseCase.validateName(controllerName.text);
      errorAge = personUseCase.validateAge(controllerAge.text);
    });

    if(errorName == null && errorAge == null) {
      Person person = Person(name: controllerName.text, age: int.parse(controllerAge.text));
      context.read<GroupProvider>().addPerson(person);

      // clear the TextFields
      controllerName.clear();
      controllerAge.clear();

      setState(() {
        errorGroup = null;
      });
    }
  }

  // function to show the date picker
  Future<void> selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2030),
    );

    if(picked!=null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final group = context.read<GroupProvider>().group;
    final stops = context.read<StopsProvider>().stops;

    return SingleChildScrollView( 
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, right: 220),
              child: Text("New Trip", style: 
                TextStyle(
                  fontFamily: "Times New Roman", 
                  fontSize: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 200, bottom: 10),
              child: Text("1. Trip Data", style: 
                TextStyle(
                  fontFamily: "Times New Roman", 
                  fontSize: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerTripTitle, 
                      hint: "Trip Title",
                      error: errorTripTitle,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
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
                      initialValue: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Car",
                          child: Text("Car"),
                        ),
                        DropdownMenuItem(
                          value: "Motorcycle",
                          child: Text("Motorcycle"),
                        ),
                        DropdownMenuItem(
                          value: "Bus",
                          child: Text("Bus"),
                        ),
                        DropdownMenuItem(
                          value: "Airplane",
                          child: Text("Airplane"),
                        ),
                        DropdownMenuItem(
                          value: "Ship",
                          child: Text("Ship"),
                        ),
                      ], 
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldDateComponent(
                      controller: controllerStartDate, 
                      hint: "Start Date", 
                      error: errorStartDate,
                      function: () => selectDate(controllerStartDate),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldDateComponent(
                      controller: controllerEndDate, 
                      hint: "End Date",
                      error: errorEndDate, 
                      function: () => selectDate(controllerEndDate),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 180, bottom: 10),
              child: Text("2. Group Data", style: 
                TextStyle(
                  fontFamily: "Times New Roman", 
                  fontSize: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerName,
                      hint: "Name",
                      error: errorName,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: TextFieldComponent(
                      controller: controllerAge, 
                      hint: "Age",
                      error: errorAge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => addPerson(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          foregroundColor: theme.colorScheme.tertiary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Add Person",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  if (group.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        children: [
                          ...group.map((person) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Chip(
                                label: Text("${person.name}(${person.age})"),
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  setState(() {
                                    context.read<GroupProvider>().removePerson(person);
                                  });
                                },
                              ),
                            );
                          }),
                        ],
                      ),  
                    ),
                  if (errorGroup != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(errorGroup!, style: 
                        TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 250, bottom: 10),
              child: Text("3. Map", style: 
                TextStyle(
                  fontFamily: "Times New Roman", 
                  fontSize: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen())),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (stops.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        children: [
                          ...stops.map((stop) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Chip(
                                label: Text(stop.location),
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  setState(() {
                                    context.read<StopsProvider>().removeStop(stop);
                                  });
                                },
                              ),
                            );
                          }),
                        ],
                      ),  
                    ),
                  if(errorStops != null) 
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(errorStops!, style: 
                        TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 65, right: 65, top: 50, bottom: 50),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => registerGroup(group, stops),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.tertiary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Register The Group",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}