import 'package:flutter/material.dart';

class TripPlannerLogo extends StatelessWidget {
  const TripPlannerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logos/trip-planner-logo.png",
      width: 350,
      fit: BoxFit.cover,
    );
  }
}