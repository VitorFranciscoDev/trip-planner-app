import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/logout_dialog.dart';

class LogOutContainer extends StatelessWidget {
  const LogOutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => LogOutDialog(),
        );
      },
      child: Container(
        height: 30,
        color: theme.colorScheme.secondary,
        child: Center(
          child: Text("Log Out", style: 
            TextStyle(
              color: theme.colorScheme.tertiary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}