import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/logout_dialog.dart';

class LogOutContainer extends StatelessWidget {
  const LogOutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => LogOutDialog(),
        );
      },
      child: Container(
        width: 70,
        height: 20,
        color: Colors.yellow,
        child: const Center(
          child: Text("Log Out"),
        ),
      ),
    );
  }
}