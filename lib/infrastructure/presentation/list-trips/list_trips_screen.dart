import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/trip-details/trip_details_screen.dart';

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
      start_date: "7/8/0", 
      end_date: "9/8/0",
      concluded: false,
      group: [
        Person(name: "Vitor", age: 9),
        Person(name: "ISabella", age: 8),
        Person(name: "Andrea", age: 7),
      ],
      stops: [
        Stop(location: "Vasco", startDate: "1", endDate: "8", latitude: 98.4, longitude: 87.4),
        Stop(location: "papapa", startDate: "1", endDate: "8", latitude: 4, longitude: 3),
        Stop(location: "eirir", startDate: "1", endDate: "8", latitude: 2, longitude: 1),
      ],
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    //final trips = context.read<TripProvider>().trips;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.yourTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.activeTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 25),
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
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: trip))),
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
                                "${trip.start_date} - ${trip.end_date}",
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
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.concludedTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 25),
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
                              "${trip.start_date} - ${trip.end_date}",
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