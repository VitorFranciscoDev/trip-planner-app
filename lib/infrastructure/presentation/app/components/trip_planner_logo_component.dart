import 'package:flutter/material.dart';

class TripPlannerLogoComponent extends StatelessWidget {
  const TripPlannerLogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      "Trip Planner",
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        fontFamily: "Times New Roman",
        color: theme.colorScheme.primary,
      ),
    );
  }
}