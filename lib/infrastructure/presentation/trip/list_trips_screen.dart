import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_details_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class ListTripsScreen extends StatefulWidget {
  const ListTripsScreen({super.key});

  @override
  State<ListTripsScreen> createState() => _ListTripsScreenState();
}

class _ListTripsScreenState extends State<ListTripsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        context.read<TripProvider>().getAllTrips(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final trips = context.watch<TripProvider>().trips;
    final activeTrips = trips.where((trip) => !trip.concluded).toList();
    final concludedTrips = trips.where((trip) => trip.concluded).toList();

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
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: activeTrips.length,
                itemBuilder: (context, index) {
                  final activeTrip = activeTrips[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: activeTrip))),
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
                            const SizedBox(width: 15),
                            Icon(Icons.airplanemode_active, color: theme.colorScheme.primary, size: 18),
                            const SizedBox(width: 10),
                            Text(
                              activeTrip.title, 
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontFamily: "Times New Roman",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
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
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: concludedTrips.length,
                itemBuilder: (context, index) {
                  final concludedTrip = concludedTrips[index];
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
                              concludedTrip.title,
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
                              "${concludedTrip.start_date} - ${concludedTrip.end_date}",
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}