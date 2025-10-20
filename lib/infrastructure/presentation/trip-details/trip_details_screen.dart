import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({ super.key, required this.trip });
  final Trip trip;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stops = widget.trip.stops;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                widget.trip.title,
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Details",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 310,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Stops",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 310,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: stops!.length,
                  itemBuilder: (context, index) {
                    final stop = stops[index];
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
                                  stop.location,
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
                                  stop.location,
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
            ],
          ),
        ),
      ),
    );
  }
}