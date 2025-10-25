import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  const AlertDialogComponent({ super.key, required this.title, this.message, this.function1, this.function1Message, required this.function2, required this.function2Message });
  final String title;
  final String? message;
  final VoidCallback? function1;
  final String? function1Message;
  final VoidCallback function2;
  final String function2Message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: [
        if(function1 != null)
          TextButton(
            style: TextButton.styleFrom(

            ),
            onPressed: () => function1!(), 
            child: Text(function1Message!),
          ),
        TextButton(
          style: TextButton.styleFrom(
            
          ),
          onPressed: () => function2(), 
          child: Text(function2Message),
        ),
      ],
    );
  }
}