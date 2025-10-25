import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  const ButtonComponent({ super.key, required this.function, required this.message });
  final Function function;
  final String message;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: () => widget.function(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: theme.colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        widget.message,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}