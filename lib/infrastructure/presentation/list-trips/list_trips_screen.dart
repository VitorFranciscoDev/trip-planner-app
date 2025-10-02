import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class ListTripsScreen extends StatefulWidget {
  const ListTripsScreen({super.key});

  @override
  State<ListTripsScreen> createState() => _ListTripsScreenState();
}

class _ListTripsScreenState extends State<ListTripsScreen> {
  List<String> aaa = ["aaa", "eeee"];

  @override
  Widget build(BuildContext context) {
    final trips = context.read<TripProvider>().trips;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text("Your Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80, right: 200),
            child: Text("Active Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200, right: 200),
            child: Text("Concluded Trips", 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
              ),
            ),
          ),
          ListView.builder(
            itemCount: aaa.length,
            itemBuilder: (context, index) {
              final eeeeee = aaa[index];
              return Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF8B4513),
                    width: 2,
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}