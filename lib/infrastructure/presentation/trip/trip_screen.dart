import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_screen.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  //1. Controllers
  TextEditingController controllerTripTitle = TextEditingController();
  TextEditingController controllerStartDate = TextEditingController();
  TextEditingController controllerEndDate = TextEditingController();

  //2. Controllers
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();

  //Value of the DropdownButton
  String dropdownValue = "Car";

  //Group
  List<Person> group = [];

  //1. Error Text
  String? errorTripTitle;
  String? errorStartDate;
  String? errorEndDate;

  //2. Error Text
  String? errorName;
  String? errorAge;
  String? errorGroup;

  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

  //Function to verify and register all the Trip Data
  void registerGroup() {
    setState(() {
      //Trip Title Verification
      if(controllerTripTitle.text.isEmpty) {
        errorTripTitle = "Trip Title cannot be blank";
      } else {
        errorTripTitle = null;
      }

      //Date Verification
      DateTime? start = parseDate(controllerStartDate.text);
      DateTime? end = parseDate(controllerEndDate.text);

      if (start == null) {
        errorStartDate = "Start date cannot be blank";
      } else {
        errorStartDate = null;
      }

      if (end == null) {
        errorEndDate = "End date cannot be blank";
      } else {
        errorEndDate = null;
      }

      if (start != null && end != null) {
        if (start.isAfter(end)) {
          errorStartDate = "Start date cannot be after end date";
          errorEndDate = "Start date cannot be after end date";
        } else {
          errorStartDate = null;
          errorEndDate = null;
        }
      }

      if(group.isEmpty) {
        errorGroup = "Group cannot be empty";
      } else {
        errorGroup = null;
      }

      //Map Verification...
    });
  }

  //Function to verify and add a person in the group
  void addPerson() {
    setState(() {
      //Name Verification
      if(controllerName.text.isEmpty) {
        errorName = "Name cannot be blank";
      } else if(!RegExp(r'[a-zA-Z ]').hasMatch(controllerName.text)) {
        errorName = "Name cannot have special characters";
      } else {
        errorName = null;
      }

      //Age Verification
      if(controllerAge.text.isEmpty) {
        errorAge = "Age cannot be blank";
      } else if(!RegExp(r'[0-9]').hasMatch(controllerAge.text)) {
        errorAge = "Age must have only numbers";
      } else {
        errorAge = null;
      }
    });

    if(errorName == null && errorAge == null) {
      group.add(Person(name: controllerName.text, age: int.parse(controllerAge.text)));

      //Clear the TextFields
      controllerName.clear();
      controllerAge.clear();
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
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
    return SingleChildScrollView ( 
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, right: 250),
              child: const Text("New Trip", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 225, bottom: 10),
              child: const Text("1. Trip Data", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ),
            Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: controllerTripTitle,
                      decoration: InputDecoration(
                        hintText: "Trip Title",
                        errorText: errorTripTitle,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
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
                    child: TextField(
                      controller: controllerStartDate,
                      readOnly: true,
                      onTap: () => _selectDate(controllerStartDate),
                      decoration: InputDecoration(
                        hintText: "Start Date",
                        errorText: errorStartDate,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: controllerEndDate,
                      readOnly: true,
                      onTap: () => _selectDate(controllerEndDate),
                      decoration: InputDecoration(
                        hintText: "End Date",
                        errorText: errorEndDate,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 200, bottom: 10),
              child: const Text("2. Group Data", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ),
            Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: controllerName,
                      decoration: InputDecoration(
                        hintText: "Name",
                        errorText: errorName,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: TextField(
                      controller: controllerAge,
                      decoration: InputDecoration(
                        hintText: "Age",
                        errorText: errorAge,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => addPerson(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.white,
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
                  if (group.isNotEmpty) ...[
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Wrap(
                      children: [
                        ...group.map((person) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Chip(
                              label: Text("${person.name}(${person.age})"),
                              deleteIcon: Icon(Icons.close),
                              onDeleted: () {
                                group.remove(person);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                  if (errorGroup != null) ...[
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Text(errorGroup!, style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 275, bottom: 10),
              child: const Text("3. Map", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ),
            Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
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
                              icon: const Icon(Icons.fullscreen, color: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MapScreen(),
                                  ),
                                );
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
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
                  onPressed: () => registerGroup(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.white,
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