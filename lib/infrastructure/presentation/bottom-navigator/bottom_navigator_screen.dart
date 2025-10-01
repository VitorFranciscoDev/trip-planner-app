import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/config/config_screen.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_screen.dart';
import 'package:trip_planner/infrastructure/presentation/list-trips/list_trips_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_screen.dart';

class BottomNavigatorScreen extends StatelessWidget {
  BottomNavigatorScreen({super.key});

  final List<Widget> pages = [HomeScreen(), TripScreen(), ListTripsScreen(), ConfigScreen()];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<BottomNavigatorProvider>().index;
    
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (newIndex) => context.read<BottomNavigatorProvider>().setIndex(newIndex),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: Color(0xFF8B4513)),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Trip", backgroundColor: Color(0xFF8B4513)),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "List of Trips", backgroundColor: Color(0xFF8B4513)),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings", backgroundColor: Color(0xFF8B4513)),
        ],
      ),
    );
  }
}