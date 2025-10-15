import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/config/config_screen.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_screen.dart';
import 'package:trip_planner/infrastructure/presentation/list-trips/list_trips_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip-register/trip_register_screen.dart';

class BottomNavigatorScreen extends StatelessWidget {
  BottomNavigatorScreen({super.key});

  // pages of the Bottom Navigator
  final List<Widget> pages = [HomeScreen(), TripScreen(), ListTripsScreen(), ConfigScreen()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final index = context.watch<BottomNavigatorProvider>().index;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (newIndex) => context.read<BottomNavigatorProvider>().setIndex(newIndex),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: theme.colorScheme.primary),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Trip", backgroundColor: theme.colorScheme.primary),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "List of Trips", backgroundColor: theme.colorScheme.primary),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings", backgroundColor: theme.colorScheme.primary),
        ],
      ),
    );
  }
}