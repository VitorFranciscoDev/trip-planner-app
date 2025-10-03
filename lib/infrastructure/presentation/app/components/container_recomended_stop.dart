import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_state.dart';

class ContainerRecomendedStop extends StatelessWidget {
  const ContainerRecomendedStop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saStops = context.watch<RecomendedStopsProvider>().saRecomendedStops;
    final saStop = saStops[Random().nextInt(saStops.length)];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.background,
          width: 2,
        ),
      ),
      //child: Image.asset(saStop.img),
    );
  }
}