import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class ListTripsScreen extends StatefulWidget {
  const ListTripsScreen({super.key});

  @override
  State<ListTripsScreen> createState() => _ListTripsScreenState();
}

class _ListTripsScreenState extends State<ListTripsScreen> {
  List<Trip> trips = [
    Trip(
      title: "PAPAPAPAP", 
      transport: "CAR", 
      startDate: "7/8/0", 
      endDate: "9/8/0",
      group: [
        Person(name: "Vitor", age: 9),
        Person(name: "ISabella", age: 8),
        Person(name: "Andrea", age: 7),
      ],
      stops: [
        Stop(location: "Vasco", latitude: 98.4, longitude: 87.4),
        Stop(location: "papapa", latitude: 4, longitude: 3),
        Stop(location: "eirir", latitude: 2, longitude: 1),
      ],
    ),
    Trip(
      title: "PAPAPAPAP", 
      transport: "CAR", 
      startDate: "7/8/0", 
      endDate: "9/8/0",
      group: [
        Person(name: "Vitor", age: 9),
        Person(name: "ISabella", age: 8),
        Person(name: "Andrea", age: 7),
      ],
      stops: [
        Stop(location: "Vasco", latitude: 98.4, longitude: 87.4),
        Stop(location: "papapa", latitude: 4, longitude: 3),
        Stop(location: "eirir", latitude: 2, longitude: 1),
      ],
    ),
    Trip(
      title: "PAPAPAPAP", 
      transport: "CAR", 
      startDate: "7/8/0", 
      endDate: "9/8/0",
      group: [
        Person(name: "Vitor", age: 9),
        Person(name: "ISabella", age: 8),
        Person(name: "Andrea", age: 7),
      ],
      stops: [
        Stop(location: "Vasco", latitude: 98.4, longitude: 87.4),
        Stop(location: "papapa", latitude: 4, longitude: 3),
        Stop(location: "eirir", latitude: 2, longitude: 1),
      ],
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final trips = context.read<TripProvider>().trips;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60, left: 25),
            child: Text("Your Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 25),
            child: Text("- Active Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 25),
            child: Container(
              width: 310,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              trip.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              "${trip.startDate} - ${trip.endDate}",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 25),
            child: Text("- Concluded Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 25),
            child: Container(
              width: 310,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              trip.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              "${trip.startDate} - ${trip.endDate}",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}