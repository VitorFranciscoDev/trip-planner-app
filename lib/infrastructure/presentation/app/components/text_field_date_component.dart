import 'package:flutter/material.dart';

class TextFieldDateComponent extends StatefulWidget {
  const TextFieldDateComponent({ super.key, required this.controller, required this.hint, this.error, required this.function });
  final TextEditingController controller;
  final String hint;
  final String? error;
  final Future<void> Function() function;

  @override
  State<TextFieldDateComponent> createState() => _TextFieldDateComponentState();
}

class _TextFieldDateComponentState extends State<TextFieldDateComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => widget.function(),
      decoration: InputDecoration(
        hintText: widget.hint,
        errorText: widget.error,
        suffixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}