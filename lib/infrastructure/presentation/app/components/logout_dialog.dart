import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/auth/login_screen.dart';


class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Log Out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}